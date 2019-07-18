Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 21D066D5EA
	for <lists+linux-kselftest@lfdr.de>; Thu, 18 Jul 2019 22:42:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727687AbfGRUm0 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 18 Jul 2019 16:42:26 -0400
Received: from mx1.redhat.com ([209.132.183.28]:43634 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727685AbfGRUm0 (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 18 Jul 2019 16:42:26 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 0BD604628B;
        Thu, 18 Jul 2019 20:42:26 +0000 (UTC)
Received: from [10.18.17.153] (dhcp-17-153.bos.redhat.com [10.18.17.153])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id B4FB45D71A;
        Thu, 18 Jul 2019 20:42:25 +0000 (UTC)
Subject: Re: [PATCH] selftests/livepatch: push and pop dynamic debug config
From:   Joe Lawrence <joe.lawrence@redhat.com>
To:     live-patching@vger.kernel.org, linux-kselftest@vger.kernel.org
References: <20190718202948.3404-1-joe.lawrence@redhat.com>
Message-ID: <e5027867-88db-fa45-6767-286f3b7b86ad@redhat.com>
Date:   Thu, 18 Jul 2019 16:42:25 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <20190718202948.3404-1-joe.lawrence@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.29]); Thu, 18 Jul 2019 20:42:26 +0000 (UTC)
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On 7/18/19 4:29 PM, Joe Lawrence wrote:
> The livepatching self-tests tweak the dynamic debug config to verify
> the kernel log during the tests.  Enhance set_dynamic_debug() so that
> the config changes are restored when the script exits.
> 
> Note this functionality needs to keep in sync with:
>    - dynamic_debug input/output formatting
>    - functions affected by set_dynamic_debug()
> 
>    For example, push_dynamic_debug() transforms:
>      kernel/livepatch/transition.c:530 [livepatch]klp_init_transition =_ "'%s': initializing %s transition\012"
>    to:
>      file kernel/livepatch/transition.c line 530 =_
> 
> Signed-off-by: Joe Lawrence <joe.lawrence@redhat.com>
> ---
>   .../testing/selftests/livepatch/functions.sh  | 26 ++++++++++++++-----
>   1 file changed, 20 insertions(+), 6 deletions(-)
> 
> diff --git a/tools/testing/selftests/livepatch/functions.sh b/tools/testing/selftests/livepatch/functions.sh
> index de5a504ffdbc..860f27665ebd 100644
> --- a/tools/testing/selftests/livepatch/functions.sh
> +++ b/tools/testing/selftests/livepatch/functions.sh
> @@ -29,13 +29,27 @@ function die() {
>   	exit 1
>   }
>   
> -# set_dynamic_debug() - setup kernel dynamic debug
> -#	TODO - push and pop this config?
> +function push_dynamic_debug() {
> +        DYNAMIC_DEBUG=$(grep '^kernel/livepatch' /sys/kernel/debug/dynamic_debug/control | \
> +                awk -F'[: ]' '{print "file " $1 " line " $2 " " $4}')
> +}
> +
> +function pop_dynamic_debug() {
> +	if [[ -n "$DYNAMIC_DEBUG" ]]; then
> +		echo -n "$DYNAMIC_DEBUG" > /sys/kernel/debug/dynamic_debug/control
> +	fi
> +}
> +
> +# set_dynamic_debug() - save the current dynamic debug config and tweak
> +# 			it for the self-tests.  Set a script exit trap
> +#			that restores the original config.
>   function set_dynamic_debug() {
> -	cat << EOF > /sys/kernel/debug/dynamic_debug/control
> -file kernel/livepatch/* +p
> -func klp_try_switch_task -p
> -EOF
> +        push_dynamic_debug
> +        trap pop_dynamic_debug EXIT INT TERM HUP
> +        cat <<-EOF > /sys/kernel/debug/dynamic_debug/control
> +		file kernel/livepatch/* +p
> +		func klp_try_switch_task -p
> +		EOF
>   }
>   
>   # loop_until(cmd) - loop a command until it is successful or $MAX_RETRIES,
> 

I took a stab as this while working on "[PATCH v2] selftests/livepatch: 
add test skip handling​", which this applies on top of.

It works for me, though I feel that the 
/sys/kernel/debug/dynamic_debug/control output to input translation is 
brittle.  It would be nice to have some kind of mass export/import 
capability for that interface.

-- Joe
