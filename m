Return-Path: <linux-kselftest+bounces-47844-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E751CD630F
	for <lists+linux-kselftest@lfdr.de>; Mon, 22 Dec 2025 14:40:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 9FE3C301A582
	for <lists+linux-kselftest@lfdr.de>; Mon, 22 Dec 2025 13:40:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2227531AAA8;
	Mon, 22 Dec 2025 13:40:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZCj0C9be"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDDB8191484;
	Mon, 22 Dec 2025 13:40:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766410806; cv=none; b=r5RYtJmXJLsOOskn6JUkUzbnd5o4aE4CAyA/ChrrJwpWWFOjM2f7ltAmH9F05PL6e7mnkpZ8/okLJk9ULityVZbkLWT5N/x/nLDD7pSM01/XaTC7AIHDJUCsINDb99kUFiBCbBUMSvB2uiwJPlPjmlxZgSM0bI9bynW+pBr6Ldc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766410806; c=relaxed/simple;
	bh=muLgVZCdKaW2U2xDoEdjfO+6X4Y0Pnz9sEwYXNUnPt8=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=lD7qJtiix0ypQfeFjQ4VI02dENJryxY+WKaf7awEDCTO2tuW+ZyaYWwkkos404zTOoEwoLrYoRMS+a4RasvaLYK3gKDkMHAPb1pXtL0uRNEV0Hf12OP36q/xhCVO/MLeaqtqO+HpmieO9e//NXNEVRC9jerwYUB7fyHrLjp4TX8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZCj0C9be; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 35697C116D0;
	Mon, 22 Dec 2025 13:40:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1766410805;
	bh=muLgVZCdKaW2U2xDoEdjfO+6X4Y0Pnz9sEwYXNUnPt8=;
	h=From:Subject:Date:To:Cc:From;
	b=ZCj0C9beJef3axNrm2XgnoGLms2pgUlR2mrt44z9HlCo/nXdOZ10ZlKH9eCS4MOqx
	 hu406JUdw7F1SI74nsIBhNeBQ/+f56Ny32VNrnSFeDqqwhQlFZtCN1rrHzq4iWKjdZ
	 qqHK7xpVWuiFKvC9rRrYdincmqDl5IopNBmK4tz8kGXwnBFvHcl6pIkJebxNte4kTH
	 29drDNpdcYtJEBpZN14M8TTTy2io/MJJgWOdEZDEUHR5Io14zL3+tceCxBnI+RlipD
	 TuSDFuo5fAOQIVEpfijBRPUF4br/1Gm/4Jkm7gIdC63dBOHIChv0M460pGJp4QUpx9
	 iWwGwgb0UDRBg==
From: Tamir Duberstein <tamird@kernel.org>
Subject: [PATCH v2 0/3] bitmap: convert self-test to KUnit
Date: Mon, 22 Dec 2025 14:39:53 +0100
Message-Id: <20251222-bitmap-kunit-convert-v2-0-6a61a5330eff@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/4WNTQ6CMBBGr0Jm7Zgy/EVX3MOwgDLCRGlJWxsN4
 e5WLuDyveR73waenbCHa7aB4yherElApwz03JuJUcbEQIoqRarBQcLSr/h4GQmorYnsAl5oLPK
 yGYiZIU1Xx3d5H9lbl3gWH6z7HC8x/9k/wZijQl2RqpuqKIuhbqell+dZ2wW6fd+/Pj7Q1bgAA
 AA=
X-Change-ID: 20250207-bitmap-kunit-convert-92d3147b2eee
To: David Gow <davidgow@google.com>, John Hubbard <jhubbard@nvidia.com>, 
 Andrew Morton <akpm@linux-foundation.org>, 
 Geert Uytterhoeven <geert@linux-m68k.org>, 
 Madhavan Srinivasan <maddy@linux.ibm.com>, 
 Michael Ellerman <mpe@ellerman.id.au>, Nicholas Piggin <npiggin@gmail.com>, 
 Naveen N Rao <naveen@kernel.org>, Yury Norov <yury.norov@gmail.com>, 
 Rasmus Villemoes <linux@rasmusvillemoes.dk>, Shuah Khan <shuah@kernel.org>, 
 Kees Cook <kees@kernel.org>, Christophe Leroy <chleroy@kernel.org>
Cc: Muhammad Usama Anjum <usama.anjum@collabora.com>, 
 linux-kernel@vger.kernel.org, linux-m68k@lists.linux-m68k.org, 
 linuxppc-dev@lists.ozlabs.org, linux-kselftest@vger.kernel.org, 
 Tamir Duberstein <tamird@gmail.com>, 
 Alexander Potapenko <glider@google.com>
X-Mailer: b4 0.15-dev
X-Developer-Signature: v=1; a=openssh-sha256; t=1766410800; l=5806;
 i=tamird@gmail.com; h=from:subject:message-id;
 bh=muLgVZCdKaW2U2xDoEdjfO+6X4Y0Pnz9sEwYXNUnPt8=;
 b=U1NIU0lHAAAAAQAAADMAAAALc3NoLWVkMjU1MTkAAAAgtYz36g7iDMSkY5K7Ab51ksGX7hJgs
 MRt+XVZTrIzMVIAAAAGcGF0YXR0AAAAAAAAAAZzaGE1MTIAAABTAAAAC3NzaC1lZDI1NTE5AAAA
 QPdMa0k+VR5LYx68pRWGXM8XiWp2v3ywu104Hv6JbMXqGymv1ic7WHGars53bB8FK7u1ctCpS3z
 ghxhcU2RtLQk=
X-Developer-Key: i=tamird@gmail.com; a=openssh;
 fpr=SHA256:264rPmnnrb+ERkS7DDS3tuwqcJss/zevJRzoylqMsbc

This is the last remaining "Test Module" kselftest, the rest having been
converted to KUnit.

Relative to v1 this keeps benchmarks out of KUnit in light of Yury's
concerns:

On Sat, Feb 8, 2025 at 12:53 PM Yury Norov <yury.norov@gmail.com> wrote:
>
> [...]
>
> This is my evidence: sometimes people report performance or whatever
> issues on their systems, suspecting bitmaps guilty. I ask them to run
> the bitmap or find_bit test to narrow the problem. Sometimes I need to
> test a hardware I have no access to, and I have to (kindly!) ask
people
> to build a small test and run it. I don't want to ask them to rebuild
> the whole kernel, or even to build something else.
>
> https://lore.kernel.org/all/YuWk3titnOiQACzC@yury-laptop/

I tested this using:

$ tools/testing/kunit/kunit.py run --arch arm64 --make_options LLVM=1 bitmap

There was a previous attempt[2] to do this in July 2024. Please bear
with me as I try to understand and address the objections from that
time. I've spoken with Muhammad Usama Anjum, the author of that series,
and received their approval to "take over" this work. Here we go...

On 7/26/24 11:45 PM, John Hubbard wrote:
> 
> This changes the situation from "works for Linus' tab completion
> case", to "causes a tab completion problem"! :)
> 
> I think a tests/ subdir is how we eventually decided to do this [1],
> right?
> 
> So:
> 
>     lib/tests/bitmap_kunit.c
> 
> [1] https://lore.kernel.org/20240724201354.make.730-kees@kernel.org

This is true and unfortunate, but not trivial to fix because new
kallsyms tests were placed in lib/tests in commit 84b4a51fce4c
("selftests: add new kallsyms selftests")  *after* the KUnit filename
best practices were adopted.

I propose that the KUnit maintainers blaze this trail using
`string_kunit.c` which currently still lives in lib/ despite the KUnit
docs giving it as an example at lib/tests/.

On 7/27/24 12:24 AM, Shuah Khan wrote:
> 
> This change will take away the ability to run bitmap tests during
> boot on a non-kunit kernel.
> 
> Nack on this change. I wan to see all tests that are being removed
> from lib because they have been converted - also it doesn't make
> sense to convert some tests like this one that add the ability test
> during boot.

This point was also discussed in another thread[3] in which:

On 7/27/24 12:35 AM, Shuah Khan wrote:
> 
> Please make sure you aren't taking away the ability to run these tests during
> boot. 
>
> It doesn't make sense to convert every single test especially when it
> is intended to be run during boot without dependencies - not as a kunit test
> but a regression test during boot.
> 
> bitmap is one example - pay attention to the config help test - bitmap
> one clearly states it runs regression testing during boot. Any test that
> says that isn't a candidate for conversion.
> 
> I am going to nack any such conversions.

The crux of the argument seems to be that the config help text is taken
to describe the author's intent with the fragment "at boot". I think
this may be a case of confirmation bias: I see at least the following
KUnit tests with "at boot" in their help text:
- CPUMASK_KUNIT_TEST
- BITFIELD_KUNIT
- CHECKSUM_KUNIT
- UTIL_MACROS_KUNIT

It seems to me that the inference being made is that any test that runs
"at boot" is intended to be run by both developers and users, but I find
no evidence that bitmap in particular would ever provide additional
value when run by users.

There's further discussion about KUnit not being "ideal for cases where
people would want to check a subsystem on a running kernel", but I find
no evidence that bitmap in particular is actually testing the running
kernel; it is a unit test of the bitmap functions, which is also stated
in the config help text.

David Gow made many of the same points in his final reply[4], which was
never replied to.

Link: https://lore.kernel.org/all/20250207-printf-kunit-convert-v2-0-057b23860823@gmail.com/T/#u [0]
Link: https://lore.kernel.org/all/20250207-scanf-kunit-convert-v4-0-a23e2afaede8@gmail.com/T/#u [1]
Link: https://lore.kernel.org/all/20240726110658.2281070-1-usama.anjum@collabora.com/T/#u [2]
Link: https://lore.kernel.org/all/327831fb-47ab-4555-8f0b-19a8dbcaacd7@collabora.com/T/#u [3]
Link: https://lore.kernel.org/all/CABVgOSmMoPD3JfzVd4VTkzGL2fZCo8LfwzaVSzeFimPrhgLa5w@mail.gmail.com/ [4]

Thanks for your attention.

Signed-off-by: Tamir Duberstein <tamird@gmail.com>
---
Changes in v2:
- Rebase on v6.19-rc1, dropping the first patch.
- Extract benchmarks into new module and deduplicate
  `test_bitmap_{read,write}_perf`.
- Remove tc_err() and use KUnit assertions.
- Parameterize `test_bitmap_cut` and `test_bitmap_parse{,list}`.
- Drop KUnit boilerplate from BITMAP_KUNIT_TEST help text.
- Drop arch changes.
- Link to v1: https://lore.kernel.org/r/20250207-bitmap-kunit-convert-v1-0-c520675343b6@gmail.com

---
Tamir Duberstein (3):
      test_bitmap: extract benchmark module
      bitmap: convert self-test to KUnit
      bitmap: break kunit into test cases

 MAINTAINERS                           |   3 +-
 lib/Kconfig.debug                     |  16 +-
 lib/Makefile                          |   5 +-
 lib/bitmap_benchmark.c                |  89 +++++
 lib/{test_bitmap.c => bitmap_kunit.c} | 630 ++++++++++++++--------------------
 tools/testing/selftests/lib/Makefile  |   2 +-
 tools/testing/selftests/lib/bitmap.sh |   3 -
 tools/testing/selftests/lib/config    |   1 -
 8 files changed, 360 insertions(+), 389 deletions(-)
---
base-commit: 8f0b4cce4481fb22653697cced8d0d04027cb1e8
change-id: 20250207-bitmap-kunit-convert-92d3147b2eee

Best regards,
--  
Tamir Duberstein <tamird@gmail.com>


