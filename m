Return-Path: <linux-kselftest+bounces-49539-lists+linux-kselftest=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id MLS2FGTMb2mgMQAAu9opvQ
	(envelope-from <linux-kselftest+bounces-49539-lists+linux-kselftest=lfdr.de@vger.kernel.org>)
	for <lists+linux-kselftest@lfdr.de>; Tue, 20 Jan 2026 19:41:40 +0100
X-Original-To: lists+linux-kselftest@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id C565B49A4C
	for <lists+linux-kselftest@lfdr.de>; Tue, 20 Jan 2026 19:41:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 140F19639E9
	for <lists+linux-kselftest@lfdr.de>; Tue, 20 Jan 2026 16:39:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 440AA4534A2;
	Tue, 20 Jan 2026 16:27:08 +0000 (UTC)
X-Original-To: linux-kselftest@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD6A627FD6D;
	Tue, 20 Jan 2026 16:27:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768926428; cv=none; b=ofKPQaE71DyxSlXmHYkiSMLmyCV4vUDBrJme0t9aXRnQedvZ0XqULrJqUvl3tiKXY8UfGYDJs+6jeRLinyFMWukNuJl0/+JyIZmVB6qgNbwIGrPjyPph+d5zl/gC/JnEFkGWHDG1NVOw4jbzQboue98eVFYsh2kLv2NUYo8JbTY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768926428; c=relaxed/simple;
	bh=Skx5JiDy2YbJjmLeYnAJeoSwj9WX/kxbF27KK7ZWafs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=eBD7JUrg8J1moFo1IoCcAtQg+YSUVNpoYLhUcTDyOPUY+VzyBFyA2qm+xieJlt0/ZsP9w/8zVOQ92dEE5gXrLjd4c5YOer86or9EY7bPmHcZOe1zVne7MfjsU6FYD9fet2bXzXs04SwaSj3lItLpOWh2BOpMdNTN29OUMhGopMQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 93E211476;
	Tue, 20 Jan 2026 08:26:58 -0800 (PST)
Received: from [10.1.39.200] (XHFQ2J9959.cambridge.arm.com [10.1.39.200])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id E3B5F3F694;
	Tue, 20 Jan 2026 08:27:03 -0800 (PST)
Message-ID: <ee3750f6-dd8b-459f-bc19-8c4a857d40a7@arm.com>
Date: Tue, 20 Jan 2026 16:27:02 +0000
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 8/8] selftests/mm: report SKIP in pfnmap if a check
 fails
Content-Language: en-GB
To: "David Hildenbrand (Red Hat)" <david@kernel.org>,
 Kevin Brodsky <kevin.brodsky@arm.com>, linux-mm@kvack.org,
 linux-kselftest@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, Andrew Morton <akpm@linux-foundation.org>,
 Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, Mark Brown
 <broonie@kernel.org>, Shuah Khan <shuah@kernel.org>
References: <20260107164842.3289559-1-kevin.brodsky@arm.com>
 <20260107164842.3289559-9-kevin.brodsky@arm.com>
 <09c214df-c3aa-48e4-9587-c54c667c6ce9@kernel.org>
 <46e50e9d-0e4a-4f81-8b43-61b897ad9c34@arm.com>
 <42b9825a-adef-4e80-bbf3-bf01b9fb0054@kernel.org>
From: Ryan Roberts <ryan.roberts@arm.com>
In-Reply-To: <42b9825a-adef-4e80-bbf3-bf01b9fb0054@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-1.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	DMARC_POLICY_SOFTFAIL(0.10)[arm.com : No valid SPF, No valid DKIM,none];
	HAS_LIST_UNSUB(-0.01)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[9];
	TAGGED_RCPT(0.00)[linux-kselftest];
	ASN(0.00)[asn:7979, ipnet:2605:f480::/32, country:US];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	R_DKIM_NA(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ryan.roberts@arm.com,linux-kselftest@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	R_SPF_SOFTFAIL(0.00)[~all:c];
	TAGGED_FROM(0.00)[bounces-49539-lists,linux-kselftest=lfdr.de];
	DBL_BLOCKED_OPENRESOLVER(0.00)[arm.com:email,arm.com:mid,dfw.mirrors.kernel.org:rdns,dfw.mirrors.kernel.org:helo]
X-Rspamd-Queue-Id: C565B49A4C
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On 19/01/2026 14:32, David Hildenbrand (Red Hat) wrote:
> On 1/19/26 15:26, Ryan Roberts wrote:
>> On 19/01/2026 11:16, David Hildenbrand (Red Hat) wrote:
>>> On 1/7/26 17:48, Kevin Brodsky wrote:
>>>> pfnmap currently checks the target file in FIXTURE_SETUP(pfnmap),
>>>> meaning once for every test, and skips the test if any check fails.
>>>>
>>>> The target file is the same for every test so this is a little
>>>> overkill. More importantly, this approach means that the whole suite
>>>> will report PASS even if all the tests are skipped because kernel
>>>> configuration (e.g. CONFIG_STRICT_DEVMEM=y) prevented /dev/mem from
>>>> being mapped, for instance.
>>>>
>>>> Let's ensure that KSFT_SKIP is returned as exit code if any check
>>>> fails by performing the checks in pfnmap_init(), run once. That
>>>> function also takes care of finding the offset of the pages to be
>>>> mapped and saves it in a global. The file is still mapped/unmapped
>>>> for every test, as some of them modify the mapping.
>>>>
>>>> Signed-off-by: Kevin Brodsky <kevin.brodsky@arm.com>
>>>> ---
>>>>    tools/testing/selftests/mm/pfnmap.c | 81 ++++++++++++++++++++---------
>>>>    1 file changed, 55 insertions(+), 26 deletions(-)
>>>>
>>>> diff --git a/tools/testing/selftests/mm/pfnmap.c b/tools/testing/selftests/mm/
>>>> pfnmap.c
>>>> index 35b0e3ed54cd..e41d5464130b 100644
>>>> --- a/tools/testing/selftests/mm/pfnmap.c
>>>> +++ b/tools/testing/selftests/mm/pfnmap.c
>>>> @@ -25,8 +25,11 @@
>>>>    #include "kselftest_harness.h"
>>>>    #include "vm_util.h"
>>>>    +#define DEV_MEM_NPAGES    2
>>>> +
>>>>    static sigjmp_buf sigjmp_buf_env;
>>>>    static char *file = "/dev/mem";
>>>> +static off_t file_offset;
>>>>      static void signal_handler(int sig)
>>>>    {
>>>> @@ -88,7 +91,7 @@ static int find_ram_target(off_t *offset,
>>>>                break;
>>>>              /* We need two pages. */
>>>> -        if (end > start + 2 * pagesize) {
>>>> +        if (end > start + DEV_MEM_NPAGES * pagesize) {
>>>>                fclose(file);
>>>>                *offset = start;
>>>>                return 0;
>>>> @@ -97,9 +100,49 @@ static int find_ram_target(off_t *offset,
>>>>        return -ENOENT;
>>>>    }
>>>>    +static void pfnmap_init(void)
>>>> +{
>>>> +    size_t pagesize = getpagesize();
>>>> +    size_t size = DEV_MEM_NPAGES * pagesize;
>>>> +    int fd;
>>>> +    void *addr;
>>>> +
>>>> +    if (strncmp(file, "/dev/mem", strlen("/dev/mem")) == 0) {
>>>> +        int err = find_ram_target(&file_offset, pagesize);
>>>> +
>>>> +        if (err)
>>>> +            ksft_exit_skip("Cannot find ram target in '/proc/iomem': %s\n",
>>>> +                       strerror(-err));
>>>> +    } else {
>>>> +        file_offset = 0;
>>>> +    }
>>>> +
>>>> +    /*
>>>> +     * Make sure we can open and map the file, and perform some basic
>>>> +     * checks; skip the whole suite if anything goes wrong.
>>>> +     * A fresh mapping is then created for every test case by
>>>> +     * FIXTURE_SETUP(pfnmap).
>>>> +     */
>>>> +    fd = open(file, O_RDONLY);
>>>> +    if (fd < 0)
>>>> +        ksft_exit_skip("Cannot open '%s': %s\n", file, strerror(errno));
>>>> +
>>>> +    addr = mmap(NULL, size, PROT_READ, MAP_SHARED, fd, file_offset);
>>>> +    if (addr == MAP_FAILED)
>>>> +        ksft_exit_skip("Cannot mmap '%s': %s\n", file, strerror(errno));
>>>> +
>>>> +    if (!check_vmflag_pfnmap(addr))
>>>> +        ksft_exit_skip("Invalid file: '%s'. Not pfnmap'ed\n", file);
>>>> +
>>>> +    if (test_read_access(addr, size))
>>>> +        ksft_exit_skip("Cannot read-access mmap'ed '%s'\n", file);
>>>> +
>>>> +    munmap(addr, size);
>>>
>>> Why not keep the fd open then and supply that to all tests without the need for
>>> them to open/close?
>>>
>>> Then, also the file cannot change etc.
>>
>> I had a private conversation with Kevin about this before he posted; my very
>> minor, theorectical concern about that was that it's possible to pass in a
>> custom file to be pfnmapped and I wondered if such a file could map a device
>> region that has read side effects? In that case I think you'd want to open it
>> fresh for each test to ensure consistent starting state?
> 
> Are we aware of devices where we would actually require a new open, and not just
> a new mmap()?

Nope; as I said all hypothetical. I was just being cautious.

> 
> The reason we added support for other files was "other pfnmap'ed memory like
> NVIDIA's EGM". I'd assume that people rather should not pass in something that
> has any side-effects.
> 
>>
>> But if you think that concern is unfounded, certainly just opening it once and
>> reusing will simplify.
> 
> I would just keep it simple here, yes. If this ever becomes a real problem, my
> intuition would tell me that probably the caller is doing something unsupported
> that we just cannot easily identify+reject.

Yeah fair enough.


Thanks,
Ryan



