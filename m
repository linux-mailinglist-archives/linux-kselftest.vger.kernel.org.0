Return-Path: <linux-kselftest+bounces-43656-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 5EBAABF6199
	for <lists+linux-kselftest@lfdr.de>; Tue, 21 Oct 2025 13:41:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 1952A4F0859
	for <lists+linux-kselftest@lfdr.de>; Tue, 21 Oct 2025 11:41:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 50A9132E6AA;
	Tue, 21 Oct 2025 11:41:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="KREqtfoj"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtpout-02.galae.net (smtpout-02.galae.net [185.246.84.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94CED23F424;
	Tue, 21 Oct 2025 11:41:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.84.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761046875; cv=none; b=QcCCJYzaILfeEbODLxlTMSDhB682hix1FkzqZPO1hNkhN12gZzezsfZX45M49Pf06bor/0LMy7d6BmYMH2fDlua24VYNstVsM9PSP81IFm4VtW/s3CR0pOOyA6/yE2IHNLU7ZlF0HMQ2gmZgkizKg0JomaYfMB1SzYhEcw3Aih8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761046875; c=relaxed/simple;
	bh=9sYuvI7CEeyOifAAPVDV+AmPzekD759B0QYeLpEGUCI=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=JnV0kKNk0EGhKTVjp+JmdYeTnpDkh/ZaoD3zz2h/nwtggYPjrVQIRa9kQZZA26usoAj3qROCj4c6RM3Vutq/o11N+svP5ZS76Dyw4Y2rGWv+66mTckzrr6Lb0DIS5EicMIDAC4TjiddTvaW0p7Z0yNcD1JGpeoirhzxdWvNhpxY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=KREqtfoj; arc=none smtp.client-ip=185.246.84.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-02.galae.net (Postfix) with ESMTPS id C610D1A1584;
	Tue, 21 Oct 2025 11:41:09 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 95D0F60680;
	Tue, 21 Oct 2025 11:41:09 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 65A7A102F23E9;
	Tue, 21 Oct 2025 13:40:53 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1761046868; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:content-language:in-reply-to:references;
	bh=/aZ90aQifoTGdx/4SW58GhR5Eihj+AcxbbGAfR/vODk=;
	b=KREqtfojYKz+RqSJdaE5Q9ChNT9xLrT3xG810Ty2/IqKj+039qfFpPNtBnC6ppesSHTW+i
	km5xE+YWGWWwpZ2tEgwPPfMJ4jhbMH9tIvGOqUfXHRa18kcVvn78N2+j1zUtmDtSrpyx6V
	JFb/Wu5Z7ZPpCH3OaFqqvv403sgv8PeqLhVlgw7YT+c3v4gwixn1J0WyzU1LqdLh+o4n6k
	K4O+kfQmUj7K36l4m5svE1GomH3AeXFnb0kx2hlE4BJiBekEPsRGqkBjeTU7Sr8oJ7OUsu
	JrqA3+Kt9FevtqAOV9UxEEA5jzvDakd+aO5fumJR4Ug661kwliKPHv1yCVx2tg==
Message-ID: <eb98c4ea-6f12-42b0-a2a2-1f53963d4e52@bootlin.com>
Date: Tue, 21 Oct 2025 13:40:52 +0200
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Bastien Curutchet <bastien.curutchet@bootlin.com>
Subject: Re: [PATCH bpf-next v5 00/15] selftests/bpf: Integrate test_xsk.c to
 test_progs framework
To: Maciej Fijalkowski <maciej.fijalkowski@intel.com>,
 Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: =?UTF-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn@kernel.org>,
 Magnus Karlsson <magnus.karlsson@intel.com>,
 Jonathan Lemon <jonathan.lemon@gmail.com>,
 Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>,
 Andrii Nakryiko <andrii@kernel.org>, Martin KaFai Lau
 <martin.lau@linux.dev>, Eduard Zingerman <eddyz87@gmail.com>,
 Song Liu <song@kernel.org>, Yonghong Song <yonghong.song@linux.dev>,
 John Fastabend <john.fastabend@gmail.com>, KP Singh <kpsingh@kernel.org>,
 Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>,
 Jiri Olsa <jolsa@kernel.org>, Mykola Lysenko <mykolal@fb.com>,
 Shuah Khan <shuah@kernel.org>, "David S. Miller" <davem@davemloft.net>,
 Jakub Kicinski <kuba@kernel.org>, Jesper Dangaard Brouer <hawk@kernel.org>,
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
 Alexis Lothore <alexis.lothore@bootlin.com>,
 Network Development <netdev@vger.kernel.org>, bpf <bpf@vger.kernel.org>,
 "open list:KERNEL SELFTEST FRAMEWORK" <linux-kselftest@vger.kernel.org>,
 LKML <linux-kernel@vger.kernel.org>
References: <20251016-xsk-v5-0-662c95eb8005@bootlin.com>
 <CAADnVQLLBrawW6N4BcPvhYD2Cg_qaxSZDRU53Jq31QxR3mPDkw@mail.gmail.com>
 <aPN1dy1OVaNiB5IB@boxer>
Content-Language: en-US
In-Reply-To: <aPN1dy1OVaNiB5IB@boxer>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Last-TLS-Session-Version: TLSv1.3

Hi

On 10/18/25 1:09 PM, Maciej Fijalkowski wrote:
> On Fri, Oct 17, 2025 at 11:27:26AM -0700, Alexei Starovoitov wrote:
>> On Thu, Oct 16, 2025 at 12:45 AM Bastien Curutchet (eBPF Foundation)
>> <bastien.curutchet@bootlin.com> wrote:
>>>
>>> Hi all,
>>>
>>> Now that the merge window is over, here's a respin of the previous
>>> iteration rebased on the latest bpf-next_base. The bug triggering the
>>> XDP_ADJUST_TAIL_SHRINK_MULTI_BUFF failure when CONFIG_DEBUG_VM is
>>> enabled hasn't been fixed yet so I've moved the test to the flaky
>>> table.
>>>
>>> The test_xsk.sh script covers many AF_XDP use cases. The tests it runs
>>> are defined in xksxceiver.c. Since this script is used to test real
>>> hardware, the goal here is to leave it as it is, and only integrate the
>>> tests that run on veth peers into the test_progs framework.
>>>
>>> Some tests are flaky so they can't be integrated in the CI as they are.
>>> I think that fixing their flakyness would require a significant amount of
>>> work. So, as first step, I've excluded them from the list of tests
>>> migrated to the CI (cf PATCH 14). If these tests get fixed at some
>>> point, integrating them into the CI will be straightforward.
>>>
>>> PATCH 1 extracts test_xsk[.c/.h] from xskxceiver[.c/.h] to make the
>>> tests available to test_progs.
>>> PATCH 2 to 7 fix small issues in the current test
>>> PATCH 8 to 13 handle all errors to release resources instead of calling
>>> exit() when any error occurs.
>>> PATCH 14 isolates some flaky tests
>>> PATCH 15 integrate the non-flaky tests to the test_progs framework
>>
>> Looks good, but why does it take so long to run?
>>
>> time ./test_progs -t xsk
>> Summary: 2/66 PASSED, 0 SKIPPED, 0 FAILED
>>
>> real    0m29.031s
>> user    0m4.414s
>> sys     0m20.893s
>>
>> That's a big addition to overall test_progs time.
>> Could you reduce it to a couple seconds?
> 
> it's because veth pair is setup per each test case from what i recall when
> i was pointing this out during review. it does not scale. it would be
> better to have veth created once for whole test suite. HTH.
> 

The initial test_xsk.sh was already quite long, the test migration 
hasn't affected its execution time on my side.
I've tried setting up the veth peers once for all the subtests, as 
suggested by Maciej; this results in about a 35% speed gain on my setup, 
but unfortunately, it’s still not enough to bring it down to a couple of 
seconds.

I'll investigate it further.


Best regards,
Bastien


