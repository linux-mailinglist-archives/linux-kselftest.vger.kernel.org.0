Return-Path: <linux-kselftest+bounces-5737-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E58E086E43A
	for <lists+linux-kselftest@lfdr.de>; Fri,  1 Mar 2024 16:22:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 924A8284F59
	for <lists+linux-kselftest@lfdr.de>; Fri,  1 Mar 2024 15:22:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 04FD867E8E;
	Fri,  1 Mar 2024 15:22:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="y1btmd2a"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 395571E502;
	Fri,  1 Mar 2024 15:22:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.227.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709306550; cv=none; b=R2vGUF47I16tb8cv5Pm0NK3X7Lad7vXzE+d+RuzqMTjvfYY83M7ET8b4hCa1F+ohUzaByBoOJZpETq8VrF0bTSmBxtzM9n4n8gwyRHMQuQzADhxXdf3S7aEz6RFsIl+X4MpTW+eITSQdZmDu9xRw+m1ARU+wyFKHbtp5HQ/oNZw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709306550; c=relaxed/simple;
	bh=wnwKt9wPgK3JATv1lV5i2+Gg9oBAg15ZKKFjS7rbUWA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=daobuPpRbxfJfkxbXPkYAefGYk9rkuqRCaV6oEjfwyMoBtmGh8xVSoY6MkTEhBn8G6uXkPzrZYstZfBKb7OMJOBJDKlWFFF4EYVi/1js3AxF7PBgNUroTywhq80fk7HoTFHyzCVEePhCq+/ELvW1usc/+fK+bQ2yrFcCMp7apnQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=y1btmd2a; arc=none smtp.client-ip=46.235.227.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1709306547;
	bh=wnwKt9wPgK3JATv1lV5i2+Gg9oBAg15ZKKFjS7rbUWA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=y1btmd2aUaCfzPAJG098Knd7qcOr7hfpEK765wIAhATaKq2LFTVdXH0QAsEZNHGHM
	 60XTExsX/aEzU98s/ZlAqEBSUm1Lz1Bx70QjxOAitLxIO5pXiu3Ym255ByGhZenqWk
	 FmGMBhpH0nQTCPtfYN08TRJjnb11wYAHCn3Q+G7GEnNnStWsz2ftzMxaOBkxMA2BFC
	 K27aN2jVvxD5lxYIv0BFC+f7okK0WJtMQK3NJQ68PNoHKjwSn+Pqi3WutK2xiryhXP
	 d8CN7kRSv6DLzHzgG+hn6K0ENxLI6C/BBDfefKIO2DP5/T+7lxn631zNZrmtMDGeaE
	 GdGYrpZ6mR75g==
Received: from localhost.localdomain (cola.collaboradmins.com [195.201.22.229])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: laura.nao)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id 46CE5378105A;
	Fri,  1 Mar 2024 15:22:26 +0000 (UTC)
From: Laura Nao <laura.nao@collabora.com>
To: laura.nao@collabora.com
Cc: a.hindborg@samsung.com,
	alex.gaynor@gmail.com,
	aliceryhl@google.com,
	benno.lossin@proton.me,
	bjorn3_gh@protonmail.com,
	boqun.feng@gmail.com,
	gary@garyguo.net,
	kernel@collabora.com,
	kernel@valentinobst.de,
	linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	ojeda@kernel.org,
	rust-for-linux@vger.kernel.org,
	sergio.collado@gmail.com,
	shuah@kernel.org,
	usama.anjum@collabora.com,
	wedsonaf@gmail.com
Subject: Re: [PATCH v5] kselftest: Add basic test for probing the rust sample modules
Date: Fri,  1 Mar 2024 16:22:32 +0100
Message-Id: <20240301152232.122399-1-laura.nao@collabora.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20240229155235.263157-1-laura.nao@collabora.com>
References: <20240229155235.263157-1-laura.nao@collabora.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi Miguel,

On 2/29/24 17:44, Miguel Ojeda wrote:
> On Thu, Feb 29, 2024 at 4:53 PM Laura Nao <laura.nao@collabora.com> wrote:
>>
>> Add new basic kselftest that checks if the available rust sample modules
>> can be added and removed correctly.
>>
>> Signed-off-by: Laura Nao <laura.nao@collabora.com>
>> Reviewed-by: Sergio Gonzalez Collado <sergio.collado@gmail.com>
>> Reviewed-by: Muhammad Usama Anjum <usama.anjum@collabora.com>
> 
> Thanks for this Laura!
> 
> Replying here to what you wrote in v4:
> 
>> At first, I hadn't planned for the kselftest to skip entirely if only
>> one of the two sample modules was missing. However, considering that
>> this kselftest is designed to test all available sample modules, and
>> given that both are enabled with the provided configuration file, I
>> believe it's more logical to verify the presence of both modules before
>> running the test. If either of them is missing, then we exit the test
>> with a skip code. This also covers the case where rust is not available.
> 
> I guess it depends on what is the expected behavior in kselftests in
> general and whether the user is expected to have merged the provided
> `config` or not.
> 

It's my understanding (and please correct if I'm wrong) that when a 
kselftest is shipped with a config file, that config file should be 
treated as a requirement for the test and the user is expected to use it
(running make kselftest-merge). I agree the script shouldn't blow up if
the user doesn't though, so it still makes sense to gracefully skip the
test when the requirements are not met.

> Also, what about modules being built-in / `--first-run` in `modprobe`?
> `modprobe` by default may return successfully even if no module was
> loaded (or even present, if it was builtin). In that case, is a
> kselftest script supposed to succeed, skip or fail? I would say at the
> least it should be "skip" (like it is done in the case where the
> module is not found), and I wouldn't mind "fail" either (i.e. running
> `modprobe` with `--first-run`).
>

This makes me realize that I should probably put these in the config
too:

CONFIG_MODULES=y
CONFIG_MODULE_UNLOAD=y

Adding --first-time (you meant --first-time, right?) definitely makes
sense, thanks for the pointer. I think having the modules being built-in
should be treated as a skip, same as when they are not there at all.

So something like this:

 for sample in "${rust_sample_modules[@]}"; do
-    if ! /sbin/modprobe -n -q "$sample"; then
+    if ! /sbin/modprobe -n -q --first-time "$sample"; then
         ktap_skip_all "module $sample is not found in /lib/modules/$(uname -r)"
         exit "$KSFT_SKIP"
     fi

will cover both cases.
 
> In addition, what about module removal failures? Are they ignored on
> purpose, e.g. because the kernel might not be configured with module
> unloading? If it is possible to check whether `MODULE_UNLOAD` is
> supported in the current config, it would be nice to check the removal
> also worked. And if it is not supported, skipping the removal entirely.
> 

I think it's safe to assume no other module will depend on the sample
rust modules, so is there any other reason unloading the modules 
might fail apart from MODULE_UNLOAD not being enabled? If not, then I
think we should just check if the removal worked and continue/skip the
test accordingly.

I can't just simply skip all tests like this though:

 for sample in "${rust_sample_modules[@]}"; do
     if /sbin/modprobe -q "$sample"; then
-        /sbin/modprobe -q -r "$sample"
+        if ! /sbin/modprobe -q -r "$sample"; then
+            ktap_skip_all "Failed to unload module $sample, please enable CONFIG_MODULE_UNLOAD"
+            exit "$KSFT_SKIP"
+        fi
         ktap_test_pass "$sample"
     else
         ktap_test_fail "$sample"

as the test plan has already been printed by then.
I'll need to rework the script a bit to skip the test upon errors on 
module removal.

> Finally, what about the case where `RUST` isn't enabled? I think Shuah
> mentioned it in a previous version.
> 

When rust is not enabled, no sample module is enabled either so the test
would still catch this in the first `if ! /sbin/modprobe -n -q --first-time
"$sample"` block and exit with the skip code.

If we need more granularity on the feedback provided to the user (i.e.
indication on what particular options are missing), then I guess we 
could check the current kernel config (/proc/config.gz) and skip the
entire test if any required config is missing. However, this adds an 
extra dependency on CONFIG_IKCONFIG=y and CONFIG_IKCONFIG_PROC=y.

Any advice on the best approach here?

>> +KTAP_HELPERS="${DIR}/../kselftest/ktap_helpers.sh"
>> +if [ -e "$KTAP_HELPERS" ]; then
>> +    source "$KTAP_HELPERS"
>> +else
>> +    echo "$KTAP_HELPERS file not found [SKIP]"
>> +    exit 4
>> +fi
> 
> I am not sure I understand this. In which situation could this happen?
> The helpers should always be there, no? I tested this with `make
> -C...../selftests install TARGETS=rust INSTALL_PATH=...` and it seems
> to work in that case too.
> 
> To be clear, I agree with Shuah that we should test that everything is
> working as expected. In fact, I would prefer to run with `-e` or, much
> better, use something else than bash :) But if something should never
> happen, should it be a skip? Shouldn't we just fail because the test
> infrastructure is somehow missing?
>

Kselftest exit codes are predefined
(https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/tools/testing/selftests/kselftest.h?h=v6.8-rc6#n74),
so if we use `set -e` and source a missing file we end up returning "1"
as if the test was run and failed. With this check we're sure to return
a value that makes sense in the event the helpers file ever gets moved.
 
> Orthogonally, if we want the test, shouldn't this just test the
> `source` command directly rather than a proxy (file existing)?
> 

Sure, checking the return value for source also makes sense.

Thanks!

Best,
Laura

