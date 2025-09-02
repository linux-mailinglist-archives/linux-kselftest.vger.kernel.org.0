Return-Path: <linux-kselftest+bounces-40651-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BB3CEB40F14
	for <lists+linux-kselftest@lfdr.de>; Tue,  2 Sep 2025 23:12:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2D94C7AE877
	for <lists+linux-kselftest@lfdr.de>; Tue,  2 Sep 2025 21:10:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D3C093570AA;
	Tue,  2 Sep 2025 21:11:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="vN1aNAiR"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FC822E7652;
	Tue,  2 Sep 2025 21:11:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756847512; cv=none; b=JfxC7HuH+ONAQ07WNJgofcKcG4rfmAwprRV4weKsFxHmXmJYM/1xat8g7uqRp6ExPX/FNcGuCHl7gJRUjs3QuZkaWAsnbswd8tZ8ndUkDSslud16oeLP9o6xXqbd0+x7WWb4sATH2DUDvb50keikJ51cqQN0WDkT2eT2RQ8x/qc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756847512; c=relaxed/simple;
	bh=J3UyQcqp+XhkbOE7T1z/2dZXwFXfqL8/MpWvYJE0vno=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=UtFJV5p60TjySHb1XzlZUFIPzytu+CYJ1lKF0ZfYJWW0uhoIpj9QwwEVpAuYOBhChQcJZEzUR0ZfBD8IX8E+gir8Ks+5TloHqABLnas68QnvpsJm5QHYzvYr0UaCwOlYjPq3O5XpkZYHdhNae0giwTzj70PhS/c3gLLB3/GDCbA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=vN1aNAiR; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9C604C4CEF7;
	Tue,  2 Sep 2025 21:11:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756847512;
	bh=J3UyQcqp+XhkbOE7T1z/2dZXwFXfqL8/MpWvYJE0vno=;
	h=From:Subject:Date:To:Cc:From;
	b=vN1aNAiRM2wQNjnGjOoGFVoudpKW04Nhz+lWCRm9F5sF1FdgBcz2MqcULMt69NVth
	 BPZCq0yBRjtdSgAxpgtGtXBDd9QQTbf0q/yh8fURy/d4FT2fvB6GKKNNFQmRxaWbXR
	 j91UKF2H99h06eMawBK53aiQpmujZpG6Do4nosrmucNhZ4mFMNumSMzoTYb9rC1cQD
	 8jKS6w4HFlY3Gm9MdjDfjwo9wJUEu37XPhwKG9u9dIwg9C5jzVcYeNVqltL0bQMoD3
	 ITe+DucgJrWoIXRnHaWUHIzJNn+m3lD93ZQRS/X+CUKuDFI2toUlthigTJz4DZsPeW
	 nOvviBEXp6djg==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Subject: [PATCH net-next v2 0/4] mptcp: misc. features for v6.18
Date: Tue, 02 Sep 2025 23:11:32 +0200
Message-Id: <20250902-net-next-mptcp-misc-feat-6-18-v2-0-fa02bb3188b1@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAIRdt2gC/4WNwQqDMBBEf0X23C2blGrsqf9RPKS60dCaSBLEI
 v57Q6DnHubwGGbeDpGD5Qi3aofAq43WuwzyVEE/aTcy2iEzSJJXUrJFxylnSzgvqV9wtrFHwzp
 hjUJhI6XRqtE1GQH5Ywls7Fb+H/CbQpebycbkw6eIV1H64mhJ/HGsAgkVaVY0yGdLl/uLg+P32
 YcRuuM4vkLhypbVAAAA
X-Change-ID: 20250829-net-next-mptcp-misc-feat-6-18-722fa87a60f1
To: mptcp@lists.linux.dev, Mat Martineau <martineau@kernel.org>, 
 Geliang Tang <geliang@kernel.org>, "David S. Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
 Shuah Khan <shuah@kernel.org>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-kselftest@vger.kernel.org, 
 "Matthieu Baerts (NGI0)" <matttbe@kernel.org>, 
 Eric Biggers <ebiggers@kernel.org>, Gang Yan <yangang@kylinos.cn>, 
 Christoph Paasch <cpaasch@openai.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1499; i=matttbe@kernel.org;
 h=from:subject:message-id; bh=J3UyQcqp+XhkbOE7T1z/2dZXwFXfqL8/MpWvYJE0vno=;
 b=owGbwMvMwCVWo/Th0Gd3rumMp9WSGDK2x04sMivWX6b8YdpK8+en1u702CxxKXjRiV3vo9boJ
 fS1TXpr1VHKwiDGxSArpsgi3RaZP/N5FW+Jl58FzBxWJpAhDFycAjAREW1GhhlrfkVODFuvHXV9
 +fJYzg2TGwK9MtMLDMsblK/WL2zQ92RkuHXUVWe7yZHq9Y/U78Qn5Ngu+LL7ucoF1WotDevDIfa
 nWQE=
X-Developer-Key: i=matttbe@kernel.org; a=openpgp;
 fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073

This series contains 4 independent new features:

- Patch 1: use HMAC-SHA256 library instead of open-coded HMAC.

- Patch 2: selftests: check for unexpected fallback counter increments.

- Patches 3-4: record subflows in RPS table, for aRFS support.

Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
---
Changes in v2:
- Drop previous patches 2 ("mptcp: make ADD_ADDR retransmission timeout
  adaptive") + 3 ("selftests: mptcp: remove add_addr_timeout settings"):
  They were introducing instabilities in the selftests.
- Rebased. Other patches have not been modified.
- Link to v1: https://lore.kernel.org/r/20250901-net-next-mptcp-misc-feat-6-18-v1-0-80ae80d2b903@kernel.org

---
Christoph Paasch (2):
      net: Add rfs_needed() helper
      mptcp: record subflows in RPS table

Eric Biggers (1):
      mptcp: use HMAC-SHA256 library instead of open-coded HMAC

Gang Yan (1):
      selftests: mptcp: add checks for fallback counters

 include/net/rps.h                               |  85 ++++++++++------
 net/mptcp/crypto.c                              |  35 +------
 net/mptcp/protocol.c                            |  21 ++++
 tools/testing/selftests/net/mptcp/mptcp_join.sh | 123 ++++++++++++++++++++++++
 4 files changed, 202 insertions(+), 62 deletions(-)
---
base-commit: cd8a4cfa6bb43a441901e82f5c222dddc75a18a3
change-id: 20250829-net-next-mptcp-misc-feat-6-18-722fa87a60f1

Best regards,
-- 
Matthieu Baerts (NGI0) <matttbe@kernel.org>


