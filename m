Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5B40168ED2
	for <lists+linux-kselftest@lfdr.de>; Mon, 15 Jul 2019 16:10:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387972AbfGOOKB (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 15 Jul 2019 10:10:01 -0400
Received: from mx1.redhat.com ([209.132.183.28]:57802 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388845AbfGOOKA (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 15 Jul 2019 10:10:00 -0400
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id E974530C543C;
        Mon, 15 Jul 2019 14:09:59 +0000 (UTC)
Received: from [10.18.17.153] (dhcp-17-153.bos.redhat.com [10.18.17.153])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 7C15A60C91;
        Mon, 15 Jul 2019 14:09:59 +0000 (UTC)
Subject: Re: [PATCH] selftests/livepatch: add test skip handling
To:     Kamalesh Babulal <kamalesh@linux.vnet.ibm.com>,
        live-patching@vger.kernel.org, linux-kselftest@vger.kernel.org
Cc:     shuah@kernel.org
References: <20190714142829.29458-1-joe.lawrence@redhat.com>
 <9de46fed-785c-d5c4-8a76-205674bd0912@linux.vnet.ibm.com>
From:   Joe Lawrence <joe.lawrence@redhat.com>
Message-ID: <b675ce40-40c8-69aa-0767-dc1af9fc7797@redhat.com>
Date:   Mon, 15 Jul 2019 10:09:58 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <9de46fed-785c-d5c4-8a76-205674bd0912@linux.vnet.ibm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.46]); Mon, 15 Jul 2019 14:10:00 +0000 (UTC)
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On 7/15/19 2:50 AM, Kamalesh Babulal wrote:
> On 7/14/19 7:58 PM, Joe Lawrence wrote:
>> Before running a livpeatch self-test, first verify that we've built and
>> installed the livepatch self-test kernel modules by running a 'modprobe
>> --dry-run'.  This should catch a few environment issues, including
>> !CONFIG_LIVEPATCH and !CONFIG_TEST_LIVEPATCH.  In these cases, exit
>> gracefully with test-skip status rather than test-fail status.
>>
>> Reported-by: Jiri Benc <jbenc@redhat.com>
>> Suggested-by: Shuah Khan <shuah@kernel.org>
>> Signed-off-by: Joe Lawrence <joe.lawrence@redhat.com>
> 
> Reviewed-by: Kamalesh Babulal <kamalesh@linux.vnet.ibm.com>
> 
> [...]
>>
>> +function assert_mod() {
>> +	local mod="$1"
>> +
>> +	if ! modprobe --dry-run "$mod" &>/dev/null ; then
> 
> Just a preference comment, shorter version 'modprobe -q -n'
> can be used here.
> 

Hi Kamalesh,

Re: command line options: my preference has been to use the long form 
command switches inside scripts as they are more likely to be self 
documenting than their short counterparts.  e.g. I could have guessed 
that -q is --quiet, but not that -n is --dry-run.

Re: --quiet vs. command redirection: Another detail I don't have a 
strong opinion about.  I guess I very slightly prefer the redirect so I 
don't have to research various modprobe versions to determine if --quiet 
is universally supported (it probably is).

In both cases, I'll defer to whatever reviewers think is more 
readable/conventional for the self-tests.

-- Joe
