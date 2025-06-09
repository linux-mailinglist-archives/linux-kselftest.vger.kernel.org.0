Return-Path: <linux-kselftest+bounces-34458-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E73D8AD1AED
	for <lists+linux-kselftest@lfdr.de>; Mon,  9 Jun 2025 11:47:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DB9367A26EC
	for <lists+linux-kselftest@lfdr.de>; Mon,  9 Jun 2025 09:45:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 86CA7253920;
	Mon,  9 Jun 2025 09:46:42 +0000 (UTC)
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-ej1-f51.google.com (mail-ej1-f51.google.com [209.85.218.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A96AF1B78F3;
	Mon,  9 Jun 2025 09:46:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749462402; cv=none; b=M+CGgbDCfZWdg3YemOyVevzPpLk4NYFAXvwN6KXhhTkMsMK0o5m6MxbTXA/QF3x4pTRGiyX8xDD0Ic9uL7hF/mkZpU8Q7zpl6KVdi3DXzIyXA8N9mNzLaXDvyOYyEStwdHzAmWVZGdr85E6CJhhYTulr+CHlg4FWerAFrUsJo6w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749462402; c=relaxed/simple;
	bh=M77Dohdcks7F+pmdLkwjKzh3y7A/CL8UcrnCn8JYYjY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=b3KntWxCeCd57fVF0sXQ/MW0HoMMEOfR5PWomVec3Zkr49Usjx1OYgS3i5EA1AgYIkmiVJZuIAGj4TPSHKE/J14rej9+FQaHLqP0mbgRmRS9T42sfJfwMNJpcSfiL2vJCemQkOgvP+2NK/BlR+uIyqnAy0H2FssklGmb6u3FPC8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.218.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f51.google.com with SMTP id a640c23a62f3a-ade33027bcfso303041466b.1;
        Mon, 09 Jun 2025 02:46:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749462399; x=1750067199;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8m3a7UChjUd7XKPt0ibqoeBEr419vnR0BHhyGlJO5vk=;
        b=Kb2ye8AkJNFI1Q23sJL84kcPhgX7RSJMsYENEUwrtQxgmU9Sbp8fqJ5NGvHBxMYwht
         +/ZB2HAjGGwya2Uvrpo2RFLNiYCyywCxCyKpVc9WY/k5JqomKn6JX64i5NmiGK3/WdrL
         ledhP/CBCRpnmYvEpZaBmYu3JXwXZ4cnSE2qpjU8p44qPgIlOotEzFFNT8uSgMvF3cQP
         +e8ed6WfGvno/0zlaTP3MvDTMP+3js943uoE5zDvFE4HwQxWVm8+CZteYVqDXRxOgLl/
         VUB63u5XKLaYhrZBBjx3qx00CmeUnks1egZjyAwxaZfC9wMdrKGDVqaeYKuMtpikUD8f
         qRdA==
X-Forwarded-Encrypted: i=1; AJvYcCUKWBnDsRqEa9E2LCkxusSLnics8VzIcVatpTg/+9KnvKGl0yBWX94tvW6yW+NMh2Y/o4l8DtaIzkae9m0=@vger.kernel.org, AJvYcCXD+hTt0LirUxBQAHbpGBhQ2sKbCESQ3jZySZmI9Yk5YKTlSIrhV8Tp0G+Pd4pfnq5oeRZYH3B5tPXBWLOVIZdY@vger.kernel.org
X-Gm-Message-State: AOJu0YyEcvACNxzObmsdfhtx2Rd4hHy7NUk+ccN53dIpHp9GBJ2QdUjW
	I0B1FcO3VvAMT4rAtUYxJ5wt1Sdzse+ZSgXfcsttKGwUlwiDdzw/ZOQkc/pkLg==
X-Gm-Gg: ASbGnctjytImdRnBvz5f+jiedUTQ5XSYUBSNAmCVsU+z4qMtszP7DQm+jct15qI13e8
	bF3F/YWdIMKVfTR2o/lcFqSbCjy93C4H+1b3DiZxfwfahfWPhkQ4FRvY0l7QqUaBZCZLLxOL2gn
	Pq8xfwyl0ZYJOAk6md7Gx6+Mfs6KKinefYH5p8eRw5xL/PhoIsXwX4Qw5TZsqxQYUu7/oypcb7O
	2kg3cHkuDOsX8jzyswJE2E5O6PZ6OW7w6dzJ4GEfVFJn24FVptUst6v/YbUMbgc+q5zsgwd83ik
	i6VoGTpkQNewJdryQ5HDHKOzKC2V7bcflrcjqrtbNQ==
X-Google-Smtp-Source: AGHT+IFf2A541fHEB70IxIl9r/qHLkmoAHSrk1DX6IYAvQjouUtGTRuKB/Oul1WEFv80beUotf6usQ==
X-Received: by 2002:a17:907:94c4:b0:acb:5c83:25b with SMTP id a640c23a62f3a-ade1a9c818amr1211994966b.7.1749462398564;
        Mon, 09 Jun 2025 02:46:38 -0700 (PDT)
Received: from localhost ([2a03:2880:30ff:1::])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ade1dc3a4absm532197866b.143.2025.06.09.02.46.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Jun 2025 02:46:38 -0700 (PDT)
From: Breno Leitao <leitao@debian.org>
Date: Mon, 09 Jun 2025 02:46:28 -0700
Subject: [PATCH net-next v3 3/4] selftests: netconsole: Do not exit from
 inside the validation function
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250609-netcons_ext-v3-3-5336fa670326@debian.org>
References: <20250609-netcons_ext-v3-0-5336fa670326@debian.org>
In-Reply-To: <20250609-netcons_ext-v3-0-5336fa670326@debian.org>
To: Breno Leitao <leitao@debian.org>, Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Tejun Heo <tj@kernel.org>, Andrew Morton <akpm@linux-foundation.org>, 
 Shuah Khan <shuah@kernel.org>, horms@kernel.org
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
 gustavold@gmail.com, Usama Arif <usamaarif642@gmail.com>, 
 linux-kselftest@vger.kernel.org, kernel-team@meta.com
X-Mailer: b4 0.15-dev-42535
X-Developer-Signature: v=1; a=openpgp-sha256; l=1842; i=leitao@debian.org;
 h=from:subject:message-id; bh=M77Dohdcks7F+pmdLkwjKzh3y7A/CL8UcrnCn8JYYjY=;
 b=owEBbQKS/ZANAwAIATWjk5/8eHdtAcsmYgBoRq14sjI2ZotnHIOJAiEOYzYnNNjI2XncK4uBZ
 Or/9NSFQcmJAjMEAAEIAB0WIQSshTmm6PRnAspKQ5s1o5Of/Hh3bQUCaEateAAKCRA1o5Of/Hh3
 bVWZD/9zW8W8nXlsc0Vqd34Qd121sHapyvL0JszEa9ylMDHeG+VB9Z1XZRicAxqYGDP3IGIBKrk
 SayaKm1d3jaJygPa+16n3hVFNFgy7VScczfo3Ik8J9aJ+NAJ54uYIteDVj2+iyqrvzA5Shuj1XN
 RobXC3IdvDc3bq8bAVy4lzgbekzP3z9Sh0vju4ujRink3r5KGr4LW4bfAheTnXz6mHq+PWcmhTe
 VgponPTliOF00VBrqLlFpBDkYzVOijrPAPgN6Y2mdJuf07+/w5fdgc/xZk/crQkYxfPO+9KVqMR
 J8Ox2n5rxDQ26DcPt1iHV74QJvk2vhWdwOj68H5n56jzWB++f8/6so+mMdtLctHVtIH2d5eQaEw
 GrjuFBVmm3Q2M3uWn6R2IsRgYYGxhpdHnSOSRkE2oIql353zblPBbzwxwVENlrMv/rz605Lb2N5
 CJABvtRibO28ZerXQ7y/VoQorX7FI4p9LQyCDtv95GGgv98Ab5T1Q6HyHG81Ytgui0TQFaUsHz2
 hB2DS2yxmuyjImn7q4bb7UQ+tAQ2XI3CGPB3JRfN5ioWZf/ocNNhQaFiwXHjfZ4SGE+2P+bGsWL
 S5M5RXgb9SvzB94Hw0DTDjxiZwP2A5bdTz1YzuT2ib4S7gO1BTFZ9LcKof++d5rR51G9FQkKd8S
 X9H9/qxHXFJU63w==
X-Developer-Key: i=leitao@debian.org; a=openpgp;
 fpr=AC8539A6E8F46702CA4A439B35A3939FFC78776D

Remove the exit call from validate_result() function and move the
test exit logic to the main script. This allows the function to
be reused in scenarios where the test needs to continue execution
after validation, rather than terminating immediately.

The validate_result() function should focus on validation logic
only, while the calling script maintains control over program
flow and exit conditions. This change improves code modularity
and prepares for potential future enhancements where multiple
validations might be needed in a single test run.

Signed-off-by: Breno Leitao <leitao@debian.org>
---
 tools/testing/selftests/drivers/net/lib/sh/lib_netcons.sh | 1 -
 tools/testing/selftests/drivers/net/netcons_basic.sh      | 2 ++
 2 files changed, 2 insertions(+), 1 deletion(-)

diff --git a/tools/testing/selftests/drivers/net/lib/sh/lib_netcons.sh b/tools/testing/selftests/drivers/net/lib/sh/lib_netcons.sh
index 29b01b8e2215c..2d5dd3297693c 100644
--- a/tools/testing/selftests/drivers/net/lib/sh/lib_netcons.sh
+++ b/tools/testing/selftests/drivers/net/lib/sh/lib_netcons.sh
@@ -185,7 +185,6 @@ function validate_result() {
 	# Delete the file once it is validated, otherwise keep it
 	# for debugging purposes
 	rm "${TMPFILENAME}"
-	exit "${ksft_pass}"
 }
 
 function check_for_dependencies() {
diff --git a/tools/testing/selftests/drivers/net/netcons_basic.sh b/tools/testing/selftests/drivers/net/netcons_basic.sh
index fe765da498e84..d2f0685d24ba3 100755
--- a/tools/testing/selftests/drivers/net/netcons_basic.sh
+++ b/tools/testing/selftests/drivers/net/netcons_basic.sh
@@ -50,3 +50,5 @@ busywait "${BUSYWAIT_TIMEOUT}" test -s "${OUTPUT_FILE}"
 # Make sure the message was received in the dst part
 # and exit
 validate_result "${OUTPUT_FILE}"
+
+exit "${ksft_pass}"

-- 
2.47.1


