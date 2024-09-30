Return-Path: <linux-kselftest+bounces-18677-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A8B498ABAD
	for <lists+linux-kselftest@lfdr.de>; Mon, 30 Sep 2024 20:10:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D6C232819FF
	for <lists+linux-kselftest@lfdr.de>; Mon, 30 Sep 2024 18:10:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 46D431990BB;
	Mon, 30 Sep 2024 18:10:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lYiS4Yb1"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18FA22B9A5;
	Mon, 30 Sep 2024 18:10:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727719842; cv=none; b=BTkd6gpLB5r2CWQl1xvVAfLNJ4dQ5tkjP8VX99rrA2DLeV6FjxNfIvZyQKRBeMnbnZ2CQrwR3HRjkxSv+18BrdvkrXfFcLRydj4Gxn8vMsOdCUu7eo66PRkFGqyfIQABQhWrkfQPqBuIs9sKfazs6oQSGlOFHD4EukJgV6L/m/w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727719842; c=relaxed/simple;
	bh=p+4eAbKdm/M8VlSF2gSqSAFLMDWbjTItNCInUwxMqGw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=Trcop4hdelnOfjx1lG20Hmvj0ZxVa6kUg7Wthcn40BcT/ycMo5CAcYAOfb/3OODjm2HEYQ8PeDcjqeZGU+sthubGDq0GYroe+Syh1sDJS2X2S37LHDpGdxNQsWdxCPWqcdgrZ5vNDGU2v7ZBoYvltG7gt9GwUhbNsxAcnP491wg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lYiS4Yb1; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F19F9C4CEC7;
	Mon, 30 Sep 2024 18:10:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727719841;
	bh=p+4eAbKdm/M8VlSF2gSqSAFLMDWbjTItNCInUwxMqGw=;
	h=From:Date:Subject:To:Cc:From;
	b=lYiS4Yb1vCHuIAsCaQcTurAgVqrd3o1pN7jYZ5wSdF+fxhFopn8+QirlCd+aza+KS
	 jn+y4x3yErrHJuxoRqj/mrHgdMPkhQghEUQ9rPCt8x9Tmxh0sbCRG5kIDr0kv+KBJ8
	 p+M+SdKs8tdfelhfKKwXerdKIb3BGS2vKNiye0eIT0onJ4ONB7jPM7zkNL8NHeHKTb
	 u/uljz3u9M4zj3OUdqFoxM/GqtM4TWTEB2Rz/DpbeoDfYTiMKIjXkmV3QIC1hOMDr8
	 fbfLnEA5C0vQLkqMMG1C1+6r2xfhJNqjSMYBYZU01x9B0Sb0OfOVvcY06oV+32Lm7L
	 f9Rg0BaIpkpLQ==
From: Mark Brown <broonie@kernel.org>
Date: Mon, 30 Sep 2024 19:10:33 +0100
Subject: [PATCH] KVM: selftests: Fix build on architectures other than
 x86_64
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20240930-kvm-build-breakage-v1-1-866fad3cc164@kernel.org>
X-B4-Tracking: v=1; b=H4sIAJnp+mYC/x2MWwqAIBAArxL7nWBmz6tEH5ZrLfZCSQLp7kmfA
 zMTwaMj9NBnERwG8nQeCYo8g3lVx4KMdGIQXEjelZzZsLPppk2zyaGyKhmqksLIWjet6SCFl0N
 Dzz8dxvf9AN36tLNkAAAA
To: Paolo Bonzini <pbonzini@redhat.com>, Shuah Khan <shuah@kernel.org>, 
 Yan Zhao <yan.y.zhao@intel.com>
Cc: Aishwarya TCV <aishwarya.tcv@arm.com>, 
 Linus Torvalds <torvalds@linux-foundation.org>, kvm@vger.kernel.org, 
 linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Mark Brown <broonie@kernel.org>
X-Mailer: b4 0.15-dev-99b12
X-Developer-Signature: v=1; a=openpgp-sha256; l=3597; i=broonie@kernel.org;
 h=from:subject:message-id; bh=p+4eAbKdm/M8VlSF2gSqSAFLMDWbjTItNCInUwxMqGw=;
 b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBm+umeiXL+eBh5K8EcsK4TkH6siaEAZW1gBwAN0rXH
 66pWKBmJATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCZvrpngAKCRAk1otyXVSH0NQCCA
 CFHs6avAhs/x2OVh92gsETEmnBwAymAqp9QZlyOU/JWZmPGxk/vEPxmoMKdTs7oFjpZY3N5bRY2Okr
 ALJcKqLzISnAt3XOKme7zK2ydzUL7oXLWMLDXmCP0AwDWOkT+xUYq2bl87NhRhxInzWYWoM1ovoyqs
 Ms0L2FOG4AY3B/x6iiYKs9zkrUWdbHJAYUJ+/u5mp5MN/wHiZRgCbMa096xObhEvPa/AC96CoaKZ3g
 zLzVkmjgHSFIj9z7JJqlhoQqHHU0clTKlc9jEgwhGFt/tDsBNnXe5UsEBSf2ZsRn5jXBgXKd6CsIdn
 E4RSa6Hw6j0GVWwR74bYYKQsiRUlMA
X-Developer-Key: i=broonie@kernel.org; a=openpgp;
 fpr=3F2568AAC26998F9E813A1C5C3F436CA30F5D8EB

The recent addition of support for testing with the x86 specific quirk
KVM_X86_QUIRK_SLOT_ZAP_ALL disabled in the generic memslot tests broke the
build of the KVM selftests for all other architectures:

In file included from include/kvm_util.h:8,
                 from include/memstress.h:13,
                 from memslot_modification_stress_test.c:21:
memslot_modification_stress_test.c: In function ‘main’:
memslot_modification_stress_test.c:176:38: error: ‘KVM_X86_QUIRK_SLOT_ZAP_ALL’ undeclared (first use in this function)
  176 |                                      KVM_X86_QUIRK_SLOT_ZAP_ALL);
      |                                      ^~~~~~~~~~~~~~~~~~~~~~~~~~

Add __x86_64__ guard defines to avoid building the relevant code on other
architectures.

Fixes: 61de4c34b51c ("KVM: selftests: Test memslot move in memslot_perf_test with quirk disabled")
Fixes: 218f6415004a ("KVM: selftests: Allow slot modification stress test with quirk disabled")
Reported-by: Aishwarya TCV <aishwarya.tcv@arm.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
This is obviously disruptive for testing of KVM changes on non-x86
architectures.
---
 tools/testing/selftests/kvm/memslot_modification_stress_test.c | 2 ++
 tools/testing/selftests/kvm/memslot_perf_test.c                | 6 ++++++
 2 files changed, 8 insertions(+)

diff --git a/tools/testing/selftests/kvm/memslot_modification_stress_test.c b/tools/testing/selftests/kvm/memslot_modification_stress_test.c
index e3343f0df9e1..c81a84990eab 100644
--- a/tools/testing/selftests/kvm/memslot_modification_stress_test.c
+++ b/tools/testing/selftests/kvm/memslot_modification_stress_test.c
@@ -169,12 +169,14 @@ int main(int argc, char *argv[])
 		case 'i':
 			p.nr_iterations = atoi_positive("Number of iterations", optarg);
 			break;
+#ifdef __x86_64__
 		case 'q':
 			p.disable_slot_zap_quirk = true;
 
 			TEST_REQUIRE(kvm_check_cap(KVM_CAP_DISABLE_QUIRKS2) &
 				     KVM_X86_QUIRK_SLOT_ZAP_ALL);
 			break;
+#endif
 		case 'h':
 		default:
 			help(argv[0]);
diff --git a/tools/testing/selftests/kvm/memslot_perf_test.c b/tools/testing/selftests/kvm/memslot_perf_test.c
index 893366982f77..989ffe0d047f 100644
--- a/tools/testing/selftests/kvm/memslot_perf_test.c
+++ b/tools/testing/selftests/kvm/memslot_perf_test.c
@@ -113,7 +113,9 @@ static_assert(ATOMIC_BOOL_LOCK_FREE == 2, "atomic bool is not lockless");
 static sem_t vcpu_ready;
 
 static bool map_unmap_verify;
+#ifdef __x86_64__
 static bool disable_slot_zap_quirk;
+#endif
 
 static bool verbose;
 #define pr_info_v(...)				\
@@ -579,8 +581,10 @@ static bool test_memslot_move_prepare(struct vm_data *data,
 	uint32_t guest_page_size = data->vm->page_size;
 	uint64_t movesrcgpa, movetestgpa;
 
+#ifdef __x86_64__
 	if (disable_slot_zap_quirk)
 		vm_enable_cap(data->vm, KVM_CAP_DISABLE_QUIRKS2, KVM_X86_QUIRK_SLOT_ZAP_ALL);
+#endif
 
 	movesrcgpa = vm_slot2gpa(data, data->nslots - 1);
 
@@ -971,11 +975,13 @@ static bool parse_args(int argc, char *argv[],
 		case 'd':
 			map_unmap_verify = true;
 			break;
+#ifdef __x86_64__
 		case 'q':
 			disable_slot_zap_quirk = true;
 			TEST_REQUIRE(kvm_check_cap(KVM_CAP_DISABLE_QUIRKS2) &
 				     KVM_X86_QUIRK_SLOT_ZAP_ALL);
 			break;
+#endif
 		case 's':
 			targs->nslots = atoi_paranoid(optarg);
 			if (targs->nslots <= 1 && targs->nslots != -1) {

---
base-commit: 9852d85ec9d492ebef56dc5f229416c925758edc
change-id: 20240930-kvm-build-breakage-a542f46d78f9

Best regards,
-- 
Mark Brown <broonie@kernel.org>


