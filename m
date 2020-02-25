Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C5ADD16E9C9
	for <lists+linux-kselftest@lfdr.de>; Tue, 25 Feb 2020 16:16:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730616AbgBYPQY (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 25 Feb 2020 10:16:24 -0500
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:50650 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1730777AbgBYPQY (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 25 Feb 2020 10:16:24 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1582643783;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=rwYYWU17L3iTa//T0R9PqKtki3pU+tfr/muWRaBusrw=;
        b=gxCyUUsL1FceJzvBrb9eL+66i8dyTly7k8V4nytLueU5iW4wQWLw5GuOaDgjH0Fz6jYxOU
        JscMWpDAN/g7lOExo6L2ibFOVFeqWipwuV9pIA51kYIiEadmX+LeZYBl9FRk/02469r8DD
        ggrmT/avJA8g49sRcoViiiqmmDXHNwk=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-73-3SjZgVAVPT6ZgjRFlciJYQ-1; Tue, 25 Feb 2020 10:16:13 -0500
X-MC-Unique: 3SjZgVAVPT6ZgjRFlciJYQ-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 24A4E800D5E;
        Tue, 25 Feb 2020 15:16:12 +0000 (UTC)
Received: from [10.18.17.119] (dhcp-17-119.bos.redhat.com [10.18.17.119])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 897735C241;
        Tue, 25 Feb 2020 15:16:11 +0000 (UTC)
Subject: Re: [PATCH] selftests/timers: Turn off timeout setting
To:     Po-Hsu Lin <po-hsu.lin@canonical.com>,
        linux-kselftest@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, shuah@kernel.org, sboyd@kernel.org,
        tglx@linutronix.de, john.stultz@linaro.org
References: <20200225101809.9986-1-po-hsu.lin@canonical.com>
From:   Joe Lawrence <joe.lawrence@redhat.com>
Message-ID: <6ee3dd78-675b-ac0e-87ce-96a7766d597b@redhat.com>
Date:   Tue, 25 Feb 2020 10:16:10 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <20200225101809.9986-1-po-hsu.lin@canonical.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On 2/25/20 5:18 AM, Po-Hsu Lin wrote:
> Tests in timers especially nsleep-lat, set-timer-lat,
> inconsistency-check and raw_skew these 4 tests can take longer than
> the default 45 seconds that introduced in commit 852c8cbf
> (selftests/kselftest/runner.sh: Add 45 second timeout per test) to run.
> 
> Disable the timeout setting for timers instead of looking for an proper
> value to make it more general.
> 
> Signed-off-by: Po-Hsu Lin <po-hsu.lin@canonical.com>
> ---
>   tools/testing/selftests/timers/settings | 1 +
>   1 file changed, 1 insertion(+)
>   create mode 100644 tools/testing/selftests/timers/settings
> 
> diff --git a/tools/testing/selftests/timers/settings b/tools/testing/selftests/timers/settings
> new file mode 100644
> index 0000000..e7b9417
> --- /dev/null
> +++ b/tools/testing/selftests/timers/settings
> @@ -0,0 +1 @@
> +timeout=0
> 

Hi,

Michael recently posted a patch that adds the various selftest settings 
files to the TEST_FILES list, ensuring that they get copied to the 
install directory along with the tests:

https://lore.kernel.org/linux-kselftest/20200220044241.2878-1-mpe@ellerman.id.au/

I think if you add that to the corresponding Makefile, you should be set.

Regards,

-- Joe

