Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4D2976888AF
	for <lists+linux-kselftest@lfdr.de>; Thu,  2 Feb 2023 22:01:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233119AbjBBVBs (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 2 Feb 2023 16:01:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54078 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233112AbjBBVBp (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 2 Feb 2023 16:01:45 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0C833834B0;
        Thu,  2 Feb 2023 13:01:45 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id AE77AB8286C;
        Thu,  2 Feb 2023 21:01:43 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B4504C433EF;
        Thu,  2 Feb 2023 21:01:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1675371702;
        bh=pAsMU92a1kCb2rKpQkLrMe9BIidKskm5XpaUiW3uPTA=;
        h=From:Date:Subject:To:Cc:From;
        b=LxuFv6qnz9tJoG3fRDTwNdWIpTUAL5nJVvHy9zVHNz2GiBMe3x00F+Bb8O68qob+q
         zwkHhxqEgN68y2n1q58Ciw+w5HiU1bRblF/GUy2uVhoXsXKdJi/bCyZyCDuw5HN1Tf
         8RDN1jU0a6rB9h2s0hkkQM5AGKDFrAuGQxf+k8tu7PWE5XdOnWs+xK0SaLa0oRreSH
         jAkB4pdmH52EsdfwB8LSeFqPeo03u4+GPtflEdWK2EJBS77IYwmpRkXWP+rse8fCeU
         1kHiseahv34X4hcThNPTh1xmJjECY9YFqYKslX9gZeBNSPdPFjO/eRcrKu7XmMiiQ5
         4UmZ4N7bDwYPg==
From:   Mark Brown <broonie@kernel.org>
Date:   Thu, 02 Feb 2023 21:01:36 +0000
Subject: [PATCH] KVM: selftests: Enable USERFAULTFD
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230202-kvm-selftest-userfaultfd-v1-1-8186ac5a33a5@kernel.org>
X-B4-Tracking: v=1; b=H4sIAK8k3GMC/x2N2wqDQAxEf0Xy3IBVpEt/pfQhq0ldtGtJ1guI/
 +7al4EzcGZ2MNbABs9iB+UlWJhihvutgLan+GEMXWaoyqouc+CwfNF4lMSWcM620Dwm6ZDJNeR
 8I+5RQ9Y9GaNXim1/DayTDlf9U5aw/R9f7+M4Aci9MzeBAAAA
To:     Paolo Bonzini <pbonzini@redhat.com>, Shuah Khan <shuah@kernel.org>,
        Oliver Upton <oliver.upton@linux.dev>
Cc:     kvm@vger.kernel.org, linux-kselftest@vger.kernel.org,
        linux-kernel@vger.kernel.org, Mark Brown <broonie@kernel.org>
X-Mailer: b4 0.12.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=972; i=broonie@kernel.org;
 h=from:subject:message-id; bh=pAsMU92a1kCb2rKpQkLrMe9BIidKskm5XpaUiW3uPTA=;
 b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBj3CSzb3mxsxHX43429e0HnfD6WwKwvfP65sZRp/4T
 gNhVqm+JATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCY9wkswAKCRAk1otyXVSH0HUKB/
 0Q0xqagueHxarbUjNpZ06zZxiVxOD1PDiq6Nngw3UZ60Z24DI+78x+vxUbPd9YNwg/kK6oKpUjX1NE
 wJLXFA9qcXpANo6EwczOrTSc6H6JF/YPlxMDtKM9dimW4l/Q9VgkxTDSZZHF9UYo28b/fUfeoeNrYE
 Gkr8rkFozuu0kSIH1glvHejvdzXB3q5gLVsEfubCm4X9CYawBEWzetCVFdLlagN7MJPsLwYTQE5dvK
 dIM9oTwMjpiyuOVK30dpr3O/w0IxNlKR+xm71G07fqcaW/FNkUklFJtl7rNTYr4AuoMeYdVC3GdeN4
 1SnAvO/ItZwBkVj73/MIgvD6lli6hz
X-Developer-Key: i=broonie@kernel.org; a=openpgp;
 fpr=3F2568AAC26998F9E813A1C5C3F436CA30F5D8EB
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

The page_fault_test KVM selftest requires userfaultfd but the config
fragment for the KVM selftests does not enable it, meaning that those tests
are skipped in CI systems that rely on appropriate settings in the config
fragments except on S/390 which happens to have it in defconfig. Enable
the option in the config fragment so that the tests get run.

Signed-off-by: Mark Brown <broonie@kernel.org>
---
 tools/testing/selftests/kvm/config | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tools/testing/selftests/kvm/config b/tools/testing/selftests/kvm/config
index 63ed533f73d6..d011b38e259e 100644
--- a/tools/testing/selftests/kvm/config
+++ b/tools/testing/selftests/kvm/config
@@ -1,3 +1,4 @@
 CONFIG_KVM=y
 CONFIG_KVM_INTEL=y
 CONFIG_KVM_AMD=y
+CONFIG_USERFAULTFD=y

---
base-commit: 1b929c02afd37871d5afb9d498426f83432e71c2
change-id: 20230202-kvm-selftest-userfaultfd-ea85a8b5f873

Best regards,
-- 
Mark Brown <broonie@kernel.org>

