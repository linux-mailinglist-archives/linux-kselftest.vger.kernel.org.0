Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7C658408B3D
	for <lists+linux-kselftest@lfdr.de>; Mon, 13 Sep 2021 14:43:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239002AbhIMMof (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 13 Sep 2021 08:44:35 -0400
Received: from mail.kernel.org ([198.145.29.99]:34138 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S238241AbhIMMoe (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 13 Sep 2021 08:44:34 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 6F42760C51;
        Mon, 13 Sep 2021 12:43:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1631536999;
        bh=rvYHoIFrq8AbzntgRj4rawmwgnFJE5ERuFQqCqZHevs=;
        h=From:To:Cc:Subject:Date:From;
        b=GQZaKn6DkDkDjMLc7/dkkZ4oAX496/EgmX9FGTjnGLhlXMfSIsBkIihsy4yYAYGNq
         tGwyDTgkaktjXeRLwBXRgr0XuwJDFkCLJPGGews7tftUnaCbgkV7CN3gVs/pqCkyty
         j5f1o72yvMQYxsmE+LJqujkZpmDXtyj+ixm7McgEmjs+Qft25nvTy+gIbkyGBCVYID
         WDMjWSAnoci2mmMnnpt+QSgF8WfKSP63Ml7U4NYi0AQ5NoG080D03JoVrFdjBN+mrP
         EYHSCc5+pKxmSEn1XGvVwLSX4kvNrWH82kcmfeG7wpRVD/erka3E7iumQgmNAJIBdQ
         c5dLZSSblkMFQ==
From:   Mark Brown <broonie@kernel.org>
To:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>, Shuah Khan <shuah@kernel.org>,
        Shuah Khan <skhan@linuxfoundation.org>
Cc:     linux-arm-kernel@lists.infradead.org,
        linux-kselftest@vger.kernel.org, Mark Brown <broonie@kernel.org>
Subject: [PATCH v1 0/4] selftests: arm64: vec-syscfg updates
Date:   Mon, 13 Sep 2021 13:37:07 +0100
Message-Id: <20210913123711.51274-1-broonie@kernel.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=807; h=from:subject; bh=rvYHoIFrq8AbzntgRj4rawmwgnFJE5ERuFQqCqZHevs=; b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBhP0Xy8AyQ4OuIrvEdWiEfBf8BQRzy6k3onbudc8EI 7IbxmACJATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCYT9F8gAKCRAk1otyXVSH0IF4B/ wPNBCUuRejQVu27COtHCx1Jc/Efuw19N6LWczNN4eqF16SIXN3bGj5k7BW9ieEuncz/jTns7IHIY0K vQCP0nSqPRE1uyaoT0bhExq9WZ91Ja7TtkXeYzsMQUCOFkX7U9/rOfTD6T4uap49eWsC/Pw8nEDh3D w+WYrgi4iKTJUnn3v+jGUGNDN9KX8m1vF78h2hyBU/GnpprQdTR1qCYlpeFfetLZqNZtUzhpHXqaTT 8zM34QS0lpFhL8dxxa9FqUMvmHtbSw7jjsjaXREqEsKXI5P9NPX3ie99jg3TH+zz4Lx3NR1x2qm4gt 1hfRaRK0zJ8zww7cynH5jMko9tvbMf
X-Developer-Key: i=broonie@kernel.org; a=openpgp; fpr=3F2568AAC26998F9E813A1C5C3F436CA30F5D8EB
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

This series fixes up a few issues introduced into vec-syscfg during
refactoring in the review process, then adds a new test which ensures
that the behaviour when we attempt to set a vector length which is not
supported by the current system matches what is documented in the SVE
ABI documentation.

Mark Brown (4):
  selftests: arm64: Fix printf() format mismatch in vec-syscfg
  selftests: arm64: Remove bogus error check on writing to files
  selftests: arm64: Fix and enable test for setting current VL in
    vec-syscfg
  selftests: arm64: Verify that all possible vector lengths are handled

 tools/testing/selftests/arm64/fp/vec-syscfg.c | 94 ++++++++++++++++---
 1 file changed, 81 insertions(+), 13 deletions(-)


base-commit: 6880fa6c56601bb8ed59df6c30fd390cc5f6dd8f
-- 
2.20.1

