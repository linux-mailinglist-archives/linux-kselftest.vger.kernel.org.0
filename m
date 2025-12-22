Return-Path: <linux-kselftest+bounces-47860-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C588CD6D9F
	for <lists+linux-kselftest@lfdr.de>; Mon, 22 Dec 2025 18:44:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 33954301D65B
	for <lists+linux-kselftest@lfdr.de>; Mon, 22 Dec 2025 17:44:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B2432F616F;
	Mon, 22 Dec 2025 17:44:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pooladkhay.com header.i=@pooladkhay.com header.b="He2BFBMl"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from outbound.qs.icloud.com (p-east3-cluster2-host11-snip4-4.eps.apple.com [57.103.87.235])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75EBC220687
	for <linux-kselftest@vger.kernel.org>; Mon, 22 Dec 2025 17:44:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=57.103.87.235
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766425476; cv=none; b=bDJ+H64c0VXBqlNIADQqhdP3G2EcHKrFTNrgQQEYgf+Rhk9/k05LU/MfjuZM/OU+CygwgoldLdMyOMx9+iJ0KCuWm1cd6Y2YAevISOEXS7kifo8AzLzUDEtI6sJNwp4ZboffsFgKvbunFQCm9zOBsyNBRYuTC4naL3lqigYWPNQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766425476; c=relaxed/simple;
	bh=vuDsfNry49TzMARrwmDmnGMGKhi86SmkScJTzOJ05N0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=IdP9kenejeN8Qn39aj0/pt2ykY6BEG/R6I49odlksfqLP4RsAvb3GqxDp2BkTnbDqw4DHO4oEYdi2DNbvuRiq3FaSgUCPeV02sUSf7D5MUMJEQQ01znl5DR24G72B8uUPIqhPaJWGjDcbmWtf4v7A1ymKOHPmINYHjk9iUtbFNg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pooladkhay.com; spf=pass smtp.mailfrom=pooladkhay.com; dkim=pass (2048-bit key) header.d=pooladkhay.com header.i=@pooladkhay.com header.b=He2BFBMl; arc=none smtp.client-ip=57.103.87.235
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pooladkhay.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pooladkhay.com
Received: from outbound.qs.icloud.com (unknown [127.0.0.2])
	by p00-icloudmta-asmtp-us-east-2d-60-percent-1 (Postfix) with ESMTPS id 5C5A01800110;
	Mon, 22 Dec 2025 17:44:31 +0000 (UTC)
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pooladkhay.com; s=sig1; bh=V3PonS4c1o59OrwrefNPSREyXYepf+r0QxVZ6yJnBt8=; h=From:To:Subject:Date:Message-ID:MIME-Version:x-icloud-hme; b=He2BFBMlzfugEoVZVOfKhkRf/INoaWdmcrbZ32lwyVGLghL9ngB0vbLIHwtEQTAZlqqzMLR2ftV6ADKnOUSXkTyF1YG9FPxitoXZAynhAwFXIR2PdyK78E/O1V6NPeCywgijGJl2WSl1hsCUJw+80xsTW3Gc/5opLBF1okfD4USdypQB0pWxtd0LR8eXPtDdjPfUI9FDIM5QLOrplQAGivQAtlvWs2EIzJap5BK715XCxf18OyCw7NBr7e+bXb38noY5kHlNyNormiyPhMfY8J+izPwWqxCxtUPHn3w3nwTGw5SZIo9HK9G3CDkurjHY3ODyRNi2lW5m7peiCnHBRQ==
mail-alias-created-date: 1721833214903
Received: from fedora (unknown [17.57.155.37])
	by p00-icloudmta-asmtp-us-east-2d-60-percent-1 (Postfix) with ESMTPSA id BA09718000BD;
	Mon, 22 Dec 2025 17:44:29 +0000 (UTC)
From: MJ Pooladkhay <mj@pooladkhay.com>
To: seanjc@google.com,
	pbonzini@redhat.com
Cc: shuah@kernel.org,
	kvm@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	MJ Pooladkhay <mj@pooladkhay.com>
Subject: [PATCH v2] KVM: selftests: Fix sign extension bug in get_desc64_base()
Date: Mon, 22 Dec 2025 17:42:07 +0000
Message-ID: <20251222174207.107331-1-mj@pooladkhay.com>
X-Mailer: git-send-email 2.52.0
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: JPm2R8vlCo0f_0Lf1PkdMbHt-WClFud0
X-Proofpoint-ORIG-GUID: JPm2R8vlCo0f_0Lf1PkdMbHt-WClFud0
X-Authority-Info: v=2.4 cv=IZ+KmGqa c=1 sm=1 tr=0 ts=6949837f cx=c_apl:c_pps
 a=bsP7O+dXZ5uKcj+dsLqiMw==:117 a=bsP7O+dXZ5uKcj+dsLqiMw==:17
 a=wP3pNCr1ah4A:10 a=VkNPw1HP01LnGYTKEx00:22 a=VwQbUJbxAAAA:8 a=Zm6OpU2aAAAA:8
 a=s9ombcOFDhP2u4g0ce4A:9 a=7OHkOZIn_5tYZgECawIR:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMjIyMDE2MyBTYWx0ZWRfX00rQQtRRwUyA
 z16CkL/KP6woxuCJuqhAye6ZlIJ/Gl1j7uGc8Yp8NC4vb4N6colQCcn3lwGOkUkBNOFM+RhI+Kh
 ZJOmWLZMB+PM61vuVuRyabWfnHPKrfwkFREd2IQ7NBm9w/hogA4VslzRU+LD/4vEkpmbXFDluy3
 bM57EXDk8J/d7Czm4N8TcuFcQ3dxbv6AYueF/rbZikpq0opP/tthRI0S9dBSzLDrSLwR679aRb6
 2RU/xjj0W9vCI6ppszmnSjdHPvDHQcUrGW2aE8fz9x2QhseVaALaCK3haQOsjzp6dwdIoHyqX1X
 FSRRpa8PQbsC34jCGt7
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-12-22_02,2025-12-22_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=806
 phishscore=0 spamscore=0 bulkscore=0 adultscore=0 malwarescore=0 mlxscore=0
 clxscore=1030 suspectscore=0 classifier=spam authscore=0 adjust=0 reason=mlx
 scancount=1 engine=8.22.0-2510240001 definitions=main-2512220163
X-JNJ: AAAAAAABZUEC5+DhpxFFw/uJ2nsIXZ6PHLjvZycUyxaxCsPQdlHkQK5/O2Wx01GroU2AZLnhTZDPYlcCB+fK2XSb8KTCUJE3F5Rsrp2AbdeFkqliALdQ9sDS82kuX1ED/uOBFQbZB6Ek6V7qUfYqO5LOzkb1YWFc04xgTzj4HEPEC81n1jaYHtDRfpeVIY9+dvV392l71FaIkNOPbLz7WFmSCdOhSzxp12RifG16Zc7IbVl0EH3UUmdtjd+tksGhyZ2vRX0Tfy37WltznynnNm13cNu0Y0ZX7VqFv73lLbLjUsj1Gj1dDhUBLQWmJiyUjSZpnoCysM4rekiMuj1ufDQxdUYjEREBw19ob/GdgBwwfugtv3B520YncEEpCLIQnvGsuLICZSnIHxoNtqsoCvQBlY8bWRB7q3oq93KVi3wnAkKjKfFe9e484HXGI9zP41mcYn3uh6hGzo7lkbTfvEai1VZiNUpASruso67GlftXYgzBTCgIBp2d8uU4bdWYfh1xwGsTF469M8ZCs2LXWikdecMk6EwFr1JsHwYJTGrUn+0ZxLDHR9Iu8tgIKZfCITC6E222DehjcFgP5A2r3Cz05EzHF2PL/EoyOJD3+RJNQ6e/ZmHaYGCdJvp3AnedJLEOLXbLh3i+l2UAYFa/1mwHbqTF0YWRjqP40P0poKiaE5ItxEe00oj6PDBlKlE=

The function get_desc64_base() performs a series of bitwise left shifts on
fields of various sizes. More specifically, when performing '<< 24' on
'desc->base2' (which is a u8), 'base2' is promoted to a signed integer
before shifting.

In a scenario where base2 >= 0x80, the shift places a 1 into bit 31,
causing the 32-bit intermediate value to become negative. When this
result is cast to uint64_t or ORed into the return value, sign extension
occurs, corrupting the upper 32 bits of the address (base3).

Example:
Given:
  base0 = 0x5000
  base1 = 0xd6
  base2 = 0xf8
  base3 = 0xfffffe7c

Expected return: 0xfffffe7cf8d65000
Actual return:   0xfffffffff8d65000

Fix this by explicitly casting the fields to 'uint64_t' before shifting
to prevent sign extension.

Signed-off-by: MJ Pooladkhay <mj@pooladkhay.com>
---
v2:
 - Remove the intermediate 'low' variable and use a single return statement
   as suggested by Sean Christopherson.

v1: https://lore.kernel.org/kvm/20251220021050.88490-1-mj@pooladkhay.com/

While using get_desc64_base() to set the HOST_TR_BASE value for a custom 
educational hypervisor, I observed system freezes, either immediately or
after migrating the guest to a new core. I eventually realized that KVM
uses get_cpu_entry_area() for the TR base. Switching to that fixed my
freezes (which were triple faults on one core followed by soft lockups 
on others, waiting on smp_call_function_many_cond) and helped me identify
the sign-extension bug in this helper function that was corrupting the
HOST_TR_BASE value.

Thanks,
MJ Pooladkhay

 tools/testing/selftests/kvm/include/x86/processor.h | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/tools/testing/selftests/kvm/include/x86/processor.h b/tools/testing/selftests/kvm/include/x86/processor.h
index 57d62a425..26a91bb73 100644
--- a/tools/testing/selftests/kvm/include/x86/processor.h
+++ b/tools/testing/selftests/kvm/include/x86/processor.h
@@ -436,8 +436,10 @@ struct kvm_x86_state {
 
 static inline uint64_t get_desc64_base(const struct desc64 *desc)
 {
-	return ((uint64_t)desc->base3 << 32) |
-		(desc->base0 | ((desc->base1) << 16) | ((desc->base2) << 24));
+	return (uint64_t)desc->base3 << 32 |
+	       (uint64_t)desc->base2 << 24 |
+	       (uint64_t)desc->base1 << 16 |
+	       (uint64_t)desc->base0;
 }
 
 static inline uint64_t rdtsc(void)
-- 
2.52.0


