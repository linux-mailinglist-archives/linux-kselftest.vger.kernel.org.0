Return-Path: <linux-kselftest+bounces-14747-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 886869465AA
	for <lists+linux-kselftest@lfdr.de>; Fri,  2 Aug 2024 23:58:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2AF47B22EBE
	for <lists+linux-kselftest@lfdr.de>; Fri,  2 Aug 2024 21:58:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D66A113A41E;
	Fri,  2 Aug 2024 21:58:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="parNkqDk"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A585E13A404;
	Fri,  2 Aug 2024 21:58:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722635892; cv=none; b=twahRF7RxIcvnCXdZpY5qUtByJnvelljO4RKvOisU9BahPUDrRFg42DdlZ9Dloh5MPiRkMSWsi05g3pM6Sv+00staAEoUCHMkxtdJ1t2B3iFCjWL3gpORjxPBziBLzVajmtiNhwGs16P68JD5/SDPSYgM87pNKtIRda5Sfm7wcs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722635892; c=relaxed/simple;
	bh=5rpY324QAUYw/QCRlGaB/mwmo5sxb4zpU9KvkLIQAwg=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=MY51hBLVs12/oby6kuc9KVqvDF4gG/GJNmRz9rpwF8848vZSJiQE/GAL6FZ6RD7XzcvsCn+mwSGpfZnESVCbkSKqGGtvIau3b3afvoJpDWaKkmi9lg6qTW/FsokiBQstzDTR6Wb1vbgUW0MnrBP8Kg8PfvxPCYxN4kWvyelsUBU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=parNkqDk; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 790B3C4AF09;
	Fri,  2 Aug 2024 21:58:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722635892;
	bh=5rpY324QAUYw/QCRlGaB/mwmo5sxb4zpU9KvkLIQAwg=;
	h=From:Subject:Date:To:Cc:From;
	b=parNkqDktiCEBtkYowEsLYjkFbEbUSlpXjsEKadKXwyxqPtdYvrdFsaPv3LEHpxIK
	 T5jueDhECXN77lhwjFCf6D7JQm2Ey87kjvosRdcJ4P4NXuDOc20QM30BFdnAadmpX7
	 NKEK7EpslznGb6Y6oy5oqGOEvCd4dGeTJK1P9POEUoL1JEp27GaT7ECz0fYQ00VZrg
	 NJVGbHWfdg96yCgKnrCxMA7M2mB3mKpntJqwkBSkpJ1hQAqiuL/TDjY5nDDzETBhPe
	 qVSNRhYuarBl8ktWZvVp2sDIK6nv8jjVjw67OkwpnLxz6uDNdxCIg1hvIyLkOSYiY4
	 v70PVuqWGVZ+g==
From: Mark Brown <broonie@kernel.org>
Subject: [PATCH 0/2] KVM: selftests: arm64: Make use of sysreg defintions
 in get-reg-list
Date: Fri, 02 Aug 2024 22:57:52 +0100
Message-Id: <20240802-kvm-arm64-get-reg-list-v1-0-3a5bf8f80765@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAGBWrWYC/x3MSwqAMAwA0atI1gZqLVW8irioNtbgl1REEO9uc
 fkWMw9EEqYITfaA0MWR9y2hyDMYJrcFQvbJoJU2qlYa52tFJ6s1GOhEoYALxxNdbV1ZGat67yH
 Fh9DI9z9uu/f9AC7fLdxoAAAA
To: Marc Zyngier <maz@kernel.org>, Oliver Upton <oliver.upton@linux.dev>, 
 James Morse <james.morse@arm.com>, 
 Suzuki K Poulose <suzuki.poulose@arm.com>, 
 Paolo Bonzini <pbonzini@redhat.com>, Shuah Khan <shuah@kernel.org>, 
 Catalin Marinas <catalin.marinas@arm.com>, Joey Gouly <joey.gouly@arm.com>
Cc: linux-arm-kernel@lists.infradead.org, kvmarm@lists.linux.dev, 
 kvm@vger.kernel.org, linux-kselftest@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Mark Brown <broonie@kernel.org>
X-Mailer: b4 0.15-dev-37811
X-Developer-Signature: v=1; a=openpgp-sha256; l=1403; i=broonie@kernel.org;
 h=from:subject:message-id; bh=5rpY324QAUYw/QCRlGaB/mwmo5sxb4zpU9KvkLIQAwg=;
 b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBmrVZuHlZ20O3TXuYYEggovZbucwyfka7Jlss0fLq8
 QvLGMtOJATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCZq1WbgAKCRAk1otyXVSH0JIeB/
 9r7dZRNCSJlpRiRquQJLS2vlBBfdcVvkzmT9MucmVbIJTpdaUW2ymLPcviVYIRS+R60xi2XyEAoAgD
 oQRwU2ctBf7HQr0RYb65Gxkxw15iqRyoX6IzIcgcmKEHjZEel/yrTPnf+OcQzobdueS8a/caS42xI4
 uwmiEewlRYDCk7eeiErh+9bt1oryYHnkogxc8psPz7RznXyHapXx7QLQb5Fwbd5hMI7KiW5iMSOkaB
 1T44OR/4TWdaiJbDcK3nXVWrnzpiaQRc08AvCHoA/Hp7oMH0yTvwH05uaWHZZZ8RUOFl2b+1649yx8
 WHzAiinJAL7Az5dU/F1OdwmzOb+4CV
X-Developer-Key: i=broonie@kernel.org; a=openpgp;
 fpr=3F2568AAC26998F9E813A1C5C3F436CA30F5D8EB

The system register definitions in the arm64 get-reg-list are all done
with directly specified magic numbers rather than using the definitions
we import from the main kernel.  This is error prone, and requires us to
audit the additions to get-reg-list separately to what we do when
specifying the registers for the main kernel.  Since Marc has indicated
that this isn't a deliberate or desired choice let's start using the
constants we have defined.

We first manually update the data used to filter registers based on ID
register fields to use a simplified macro that specifies the register
and ID field in a muc more compact fashion.  This is done first since
there is an error in the ID register field for the S1PIE registers.  We
then replace all the remaining named system register specifications with
use of the existing KVM_ARM64_SYS_REG() macro.

Signed-off-by: Mark Brown <broonie@kernel.org>
---
Mark Brown (2):
      KVM: selftests: arm64: Simplify specification of filtered registers
      KVM: selftests: arm64: Use generated defines for named system registers

 tools/testing/selftests/kvm/aarch64/get-reg-list.c | 237 ++++++++++-----------
 1 file changed, 115 insertions(+), 122 deletions(-)
---
base-commit: 8400291e289ee6b2bf9779ff1c83a291501f017b
change-id: 20240802-kvm-arm64-get-reg-list-a86a37460bdd

Best regards,
-- 
Mark Brown <broonie@kernel.org>


