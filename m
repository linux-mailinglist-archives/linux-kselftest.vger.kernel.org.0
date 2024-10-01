Return-Path: <linux-kselftest+bounces-18728-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E75798B725
	for <lists+linux-kselftest@lfdr.de>; Tue,  1 Oct 2024 10:38:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4CF6F28390A
	for <lists+linux-kselftest@lfdr.de>; Tue,  1 Oct 2024 08:38:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED21119DF61;
	Tue,  1 Oct 2024 08:37:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="C/vywLpT";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="IqibOtaW";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="C/vywLpT";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="IqibOtaW"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A7D619AD5C;
	Tue,  1 Oct 2024 08:37:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727771836; cv=none; b=WVUOOQvXgmVtq1c5OroefHu4alzbeLCvvdOBxnwo9LfEuELoCvJ+c1YW79BHaFZtcq7kjSrEnGxHSaFSHLzGP5BcADm8GyNUzQrp8QLVujVwob6Sneqr4FuzukNLu65W8amvJw5MoC/P++Usovj70+iGZoFsUj0c6O/JgPruyNQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727771836; c=relaxed/simple;
	bh=8a1k4nvuJee1xWuk2wirbRH2ovNTmhsw4NtFJTBefGc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=AIl6vWvUW3fE/Dhc3tE3uQqx/82FCl6GAmRzpC4fpA20qvbYuXPrMKYhzQZJsOPMz8mIabOCJtzApF+v9JJ1XhZMD7/Ledlh1Z7nhCQCJnrbcMxzCOHIv8QEx5vx23iHhxpxdPKaGG0IZs6CGz7seRN77VRjskIAyzvbOofobVM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=C/vywLpT; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=IqibOtaW; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=C/vywLpT; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=IqibOtaW; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 910BB21AFE;
	Tue,  1 Oct 2024 08:37:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1727771826; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Wz6iF7VA/XvwkekcIHafjhP+48pOMPmGqg5ohl9g+/c=;
	b=C/vywLpTeb8iVDIjG5slIvToARzmWXiYCXaqVwADoLhuFj09D0a1X/VUGGI59jnJxTJDWH
	rKSM4I7+lZRvtZOZy0VGvHKbfsGIdMk/RD+iAbDamLtMflSLPQmm8FZr8aJ2PnA7Oimb4a
	eszHU8HWWyCZKmmDqNgaD2ztK7qvuvQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1727771826;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Wz6iF7VA/XvwkekcIHafjhP+48pOMPmGqg5ohl9g+/c=;
	b=IqibOtaW835sOiirqnRMWp3ZL/xLWkEV4m1N7vFcusweGOjSkGYMAKBJ8ZEEbu9LFlKMS2
	PK1d/shX7dY2wyBA==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1727771826; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Wz6iF7VA/XvwkekcIHafjhP+48pOMPmGqg5ohl9g+/c=;
	b=C/vywLpTeb8iVDIjG5slIvToARzmWXiYCXaqVwADoLhuFj09D0a1X/VUGGI59jnJxTJDWH
	rKSM4I7+lZRvtZOZy0VGvHKbfsGIdMk/RD+iAbDamLtMflSLPQmm8FZr8aJ2PnA7Oimb4a
	eszHU8HWWyCZKmmDqNgaD2ztK7qvuvQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1727771826;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Wz6iF7VA/XvwkekcIHafjhP+48pOMPmGqg5ohl9g+/c=;
	b=IqibOtaW835sOiirqnRMWp3ZL/xLWkEV4m1N7vFcusweGOjSkGYMAKBJ8ZEEbu9LFlKMS2
	PK1d/shX7dY2wyBA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 4347913A6E;
	Tue,  1 Oct 2024 08:37:06 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id VBOhD7K0+2bgLwAAD6G6ig
	(envelope-from <vbabka@suse.cz>); Tue, 01 Oct 2024 08:37:06 +0000
Message-ID: <5ccae4ec-0b98-4f84-89be-9ba49f75e85e@suse.cz>
Date: Tue, 1 Oct 2024 10:39:35 +0200
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH slab hotfixes 2/2] kunit: move call to
 kunit_run_all_tests() after rcu_end_inkernel_boot()
To: Guenter Roeck <linux@roeck-us.net>,
 Andrew Morton <akpm@linux-foundation.org>, Christoph Lameter <cl@linux.com>,
 David Rientjes <rientjes@google.com>,
 Roman Gushchin <roman.gushchin@linux.dev>,
 Hyeonggon Yoo <42.hyeyoo@gmail.com>, linux-kernel@vger.kernel.org,
 linux-mm@kvack.org
Cc: "Paul E. McKenney" <paulmck@kernel.org>, Boqun Feng
 <boqun.feng@gmail.com>, Uladzislau Rezki <urezki@gmail.com>,
 rcu@vger.kernel.org, David Gow <davidgow@google.com>,
 Rae Moar <rmoar@google.com>, linux-kselftest@vger.kernel.org,
 kunit-dev@googlegroups.com, Brendan Higgins <brendan.higgins@linux.dev>
References: <20240930-b4-slub-kunit-fix-v1-0-32ca9dbbbc11@suse.cz>
 <20240930-b4-slub-kunit-fix-v1-2-32ca9dbbbc11@suse.cz>
 <9dd56c26-12db-4b69-af0e-fdea33bb8208@roeck-us.net>
 <ee52f8af-ef1a-4382-ab9a-f9781157d1be@roeck-us.net>
From: Vlastimil Babka <vbabka@suse.cz>
Content-Language: en-US
In-Reply-To: <ee52f8af-ef1a-4382-ab9a-f9781157d1be@roeck-us.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Score: -2.80
X-Spamd-Result: default: False [-2.80 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	SUSPICIOUS_RECIPS(1.50)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MIME_TRACE(0.00)[0:+];
	TAGGED_RCPT(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[17];
	ARC_NA(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	FREEMAIL_TO(0.00)[roeck-us.net,linux-foundation.org,linux.com,google.com,linux.dev,gmail.com,vger.kernel.org,kvack.org];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[kernel.org,gmail.com,vger.kernel.org,google.com,googlegroups.com,linux.dev];
	MID_RHS_MATCH_FROM(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	TO_DN_SOME(0.00)[]
X-Spam-Flag: NO
X-Spam-Level: 

On 10/1/24 1:55 AM, Guenter Roeck wrote:
> On 9/30/24 11:50, Guenter Roeck wrote:
>> On 9/30/24 01:37, Vlastimil Babka wrote:
>>> Guenter Roeck reports that the new slub kunit tests added by commit
>>> 4e1c44b3db79 ("kunit, slub: add test_kfree_rcu() and
>>> test_leak_destroy()") cause a lockup on boot on several architectures
>>> when the kunit tests are configured to be built-in and not modules.
>>>
>>> These tests invoke kfree_rcu() and kvfree_rcu_barrier() and boot
>>> sequence inspection showed the runner for built-in kunit tests
>>> kunit_run_all_tests() is called before setting system_state to
>>> SYSTEM_RUNNING and calling rcu_end_inkernel_boot(), so this seems like a
>>> likely cause. So while I was unable to reproduce the problem myself,
>>> moving the call to kunit_run_all_tests() a bit later in the boot seems
>>> to have fixed the lockup problem according to Guenter's limited testing.
>>>
>>> No kunit tests should be broken by calling the built-in executor a bit
>>> later, as when compiled as modules, they are still executed even later
>>> than this.
>>>
> 
> Actually, that is wrong.
> 
> Turns out kunit_iov_iter (and other kunit tests) are marked __init.
> That means those unit tests have to run before the init code is released,
> and it actually _is_ harmful to run the tests after rcu_end_inkernel_boot()
> because at that time free_initmem() has already been called.

Oh, guess that explains why the kunit_run_all_tests() executor is called
so suspiciously early. Of course when built as modules, __init has a
different lifetime.

Guess I will just skip the two new tests using kfree_rcu() when the slub
kunit is built-in then. Thanks for testing.

> Guenter
> 
>>> Fixes: 4e1c44b3db79 ("kunit, slub: add test_kfree_rcu() and
>>> test_leak_destroy()")
>>> Reported-by: Guenter Roeck <linux@roeck-us.net>
>>> Closes:
>>> https://lore.kernel.org/all/6fcb1252-7990-4f0d-8027-5e83f0fb9409@roeck-us.net/
>>> Cc: "Paul E. McKenney" <paulmck@kernel.org>
>>> Cc: Boqun Feng <boqun.feng@gmail.com>
>>> Cc: Uladzislau Rezki <urezki@gmail.com>
>>> Cc: rcu@vger.kernel.org
>>> Cc: Brendan Higgins <brendanhiggins@google.com>
>>> Cc: David Gow <davidgow@google.com>
>>> Cc: Rae Moar <rmoar@google.com>
>>> Cc: linux-kselftest@vger.kernel.org
>>> Cc: kunit-dev@googlegroups.com
>>> Signed-off-by: Vlastimil Babka <vbabka@suse.cz>
>>> ---
>>>   init/main.c | 4 ++--
>>>   1 file changed, 2 insertions(+), 2 deletions(-)
>>>
>>> diff --git a/init/main.c b/init/main.c
>>> index
>>> c4778edae7972f512d5eefe8400075ac35a70d1c..7890ebb00e84b8bd7bac28923fb1fe571b3e9ee2 100644
>>> --- a/init/main.c
>>> +++ b/init/main.c
>>> @@ -1489,6 +1489,8 @@ static int __ref kernel_init(void *unused)
>>>       rcu_end_inkernel_boot();
>>> +    kunit_run_all_tests();
>>> +
>>>       do_sysctl_args();
>>>       if (ramdisk_execute_command) {
>>> @@ -1579,8 +1581,6 @@ static noinline void __init
>>> kernel_init_freeable(void)
>>>       do_basic_setup();
>>> -    kunit_run_all_tests();
>>> -
>>>       wait_for_initramfs();
>>>       console_on_rootfs();
>>>
>> Unfortunately it doesn't work. With this patch applied, I get many
>> backtraces
>> similar to the following, and ultimately the image crashes. This is
>> with arm64.
>> I do not see the problem if I drop this patch.
>>
>> Guenter
>>
>> ---
>> [    9.465871]     KTAP version 1
>> [    9.465964]     # Subtest: iov_iter
>> [    9.466056]     # module: kunit_iov_iter
>> [    9.466115]     1..12
>> [    9.467000] Unable to handle kernel paging request at virtual
>> address ffffc37db5c9f26c
>> [    9.467244] Mem abort info:
>> [    9.467332]   ESR = 0x0000000086000007
>> [    9.467454]   EC = 0x21: IABT (current EL), IL = 32 bits
>> [    9.467576]   SET = 0, FnV = 0
>> [    9.467667]   EA = 0, S1PTW = 0
>> [    9.467762]   FSC = 0x07: level 3 translation fault
>> [    9.467912] swapper pgtable: 4k pages, 48-bit VAs,
>> pgdp=0000000042a59000
>> [    9.468055] [ffffc37db5c9f26c] pgd=0000000000000000,
>> p4d=1000000044b36003, pud=1000000044b37003, pmd=1000000044b3a003,
>> pte=0000000000000000
>> [    9.469430] Internal error: Oops: 0000000086000007 [#1] PREEMPT SMP
>> [    9.469687] Modules linked in:
>> [    9.470035] CPU: 0 UID: 0 PID: 550 Comm: kunit_try_catch Tainted:
>> G                 N 6.12.0-rc1-00005-ga65e3eb58cdb #1
>> [    9.470290] Tainted: [N]=TEST
>> [    9.470356] Hardware name: linux,dummy-virt (DT)
>> [    9.470530] pstate: 80000005 (Nzcv daif -PAN -UAO -TCO -DIT -SSBS
>> BTYPE=--)
>> [    9.470656] pc : iov_kunit_copy_to_kvec+0x0/0x334
>> [    9.471055] lr : kunit_try_run_case+0x6c/0x15c
>> [    9.471145] sp : ffff800080883de0
>> [    9.471210] x29: ffff800080883e20 x28: 0000000000000000 x27:
>> 0000000000000000
>> [    9.471376] x26: 0000000000000000 x25: 0000000000000000 x24:
>> ffff80008000bb68
>> [    9.471501] x23: ffffc37db3f7093c x22: ffff80008000b940 x21:
>> ffff545847af4c00
>> [    9.471622] x20: ffff545847cd3940 x19: ffff80008000bb50 x18:
>> 0000000000000006
>> [    9.471742] x17: 6c61746f7420303a x16: 70696b7320303a6c x15:
>> 0000000000000172
>> [    9.471863] x14: 0000000000020000 x13: 0000000000000000 x12:
>> ffffc37db6a600c8
>> [    9.471983] x11: 0000000000000043 x10: 0000000000000043 x9 :
>> 1fffffffffffffff
>> [    9.472122] x8 : 00000000ffffffff x7 : 000000001040d4fd x6 :
>> ffffc37db70c3810
>> [    9.472243] x5 : 0000000000000000 x4 : ffffffffc4653600 x3 :
>> 000000003b9ac9ff
>> [    9.472363] x2 : 0000000000000001 x1 : ffffc37db5c9f26c x0 :
>> ffff80008000bb50
>> [    9.472572] Call trace:
>> [    9.472636]  iov_kunit_copy_to_kvec+0x0/0x334
>> [    9.472740]  kunit_generic_run_threadfn_adapter+0x28/0x4c
>> [    9.472835]  kthread+0x11c/0x120
>> [    9.472903]  ret_from_fork+0x10/0x20
>> [    9.473146] Code: ???????? ???????? ???????? ???????? (????????)
>> [    9.473505] ---[ end trace 0000000000000000 ]---
>>
> 

