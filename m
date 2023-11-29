Return-Path: <linux-kselftest+bounces-823-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3FF6E7FDB34
	for <lists+linux-kselftest@lfdr.de>; Wed, 29 Nov 2023 16:25:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BE98DB210ED
	for <lists+linux-kselftest@lfdr.de>; Wed, 29 Nov 2023 15:25:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 27EBA37D3E;
	Wed, 29 Nov 2023 15:25:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sxc4fHzh"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01BE637D03;
	Wed, 29 Nov 2023 15:25:03 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 12C1FC433C9;
	Wed, 29 Nov 2023 15:25:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1701271503;
	bh=lglUK6Ur3CdUwASQTgBslEe65vEhczn7ZV7KCziVP0g=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=sxc4fHzh0Y2eCyN3G/k7rWHDOyvotcqkxnNlOupZYGA60Vu8k8v9V4HEn1M5DCzAl
	 P24rYW7EvJ8OcZwP1+vryNP1tNiUXcjKNVLPVTUqWbwYwNW6lNX9gXnwprXWzIR1pd
	 qxy9E5Fcn06mwO3aphaRu69QB76wATBhmf84K5poEnkewpsiWv9TxIPJb4nC8WJ4bt
	 eqH35xNdtxQTLeii+XplLEaw4ABkB44PUXu2Js4BUmN+pdTqQo6jOvQjK5elfCgwoB
	 ARgTMi3ykGZrRRZTsQSphhLFm+pOl46ee1qYXUZFfja+hkhq+/L1l9Q6flvbn6jSqY
	 /KFgvBgn+U0IA==
From: Benjamin Tissoires <bentiss@kernel.org>
Date: Wed, 29 Nov 2023 16:24:26 +0100
Subject: [PATCH 01/12] selftests/hid: vmtest.sh: update vm2c and container
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20231129-wip-selftests-v1-1-ba15a1fe1b0d@kernel.org>
References: <20231129-wip-selftests-v1-0-ba15a1fe1b0d@kernel.org>
In-Reply-To: <20231129-wip-selftests-v1-0-ba15a1fe1b0d@kernel.org>
To: Jiri Kosina <jikos@kernel.org>, 
 Benjamin Tissoires <benjamin.tissoires@redhat.com>, 
 Shuah Khan <shuah@kernel.org>, Peter Hutterer <peter.hutterer@who-t.net>
Cc: linux-input@vger.kernel.org, linux-kselftest@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Benjamin Tissoires <bentiss@kernel.org>
X-Mailer: b4 0.12.4
X-Developer-Signature: v=1; a=ed25519-sha256; t=1701271499; l=1422;
 i=bentiss@kernel.org; s=20230215; h=from:subject:message-id;
 bh=lglUK6Ur3CdUwASQTgBslEe65vEhczn7ZV7KCziVP0g=;
 b=UyNv9qDRZwVXeIiBK4TZRTOaBbeXhh9LFXi5nHBY/ucZyQcGfBVWczCmmvf+mWaKSYZfURa29
 Lb2gKk+5bIvCRNcQDqCQMElrQSIDmEsYI2w4zQWhrEdwn6mWBbwJMkB
X-Developer-Key: i=bentiss@kernel.org; a=ed25519;
 pk=7D1DyAVh6ajCkuUTudt/chMuXWIJHlv2qCsRkIizvFw=

boot2container is now on an official project, so let's use that.
The container image is now the same I use for the CI, so let's keep
to it.

Signed-off-by: Benjamin Tissoires <bentiss@kernel.org>
---
 tools/testing/selftests/hid/vmtest.sh | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/tools/testing/selftests/hid/vmtest.sh b/tools/testing/selftests/hid/vmtest.sh
index 4da48bf6b328..301b4e162336 100755
--- a/tools/testing/selftests/hid/vmtest.sh
+++ b/tools/testing/selftests/hid/vmtest.sh
@@ -19,12 +19,12 @@ esac
 SCRIPT_DIR="$(dirname $(realpath $0))"
 OUTPUT_DIR="$SCRIPT_DIR/results"
 KCONFIG_REL_PATHS=("${SCRIPT_DIR}/config" "${SCRIPT_DIR}/config.common" "${SCRIPT_DIR}/config.${ARCH}")
-B2C_URL="https://gitlab.freedesktop.org/mupuf/boot2container/-/raw/master/vm2c.py"
+B2C_URL="https://gitlab.freedesktop.org/gfx-ci/boot2container/-/raw/main/vm2c.py"
 NUM_COMPILE_JOBS="$(nproc)"
 LOG_FILE_BASE="$(date +"hid_selftests.%Y-%m-%d_%H-%M-%S")"
 LOG_FILE="${LOG_FILE_BASE}.log"
 EXIT_STATUS_FILE="${LOG_FILE_BASE}.exit_status"
-CONTAINER_IMAGE="registry.freedesktop.org/libevdev/hid-tools/fedora/37:2023-02-17.1"
+CONTAINER_IMAGE="registry.freedesktop.org/bentiss/hid/fedora/39:2023-11-22.1"
 
 TARGETS="${TARGETS:=$(basename ${SCRIPT_DIR})}"
 DEFAULT_COMMAND="pip3 install hid-tools; make -C tools/testing/selftests TARGETS=${TARGETS} run_tests"

-- 
2.41.0


