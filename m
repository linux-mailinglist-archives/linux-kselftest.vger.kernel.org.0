Return-Path: <linux-kselftest+bounces-44088-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 57C1DC0CECE
	for <lists+linux-kselftest@lfdr.de>; Mon, 27 Oct 2025 11:20:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 648361895DBE
	for <lists+linux-kselftest@lfdr.de>; Mon, 27 Oct 2025 10:20:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 24B072E8B7E;
	Mon, 27 Oct 2025 10:20:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=canonical.com header.i=@canonical.com header.b="F1KwVCjL"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp-relay-canonical-0.canonical.com (smtp-relay-canonical-0.canonical.com [185.125.188.120])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B4D2134BD;
	Mon, 27 Oct 2025 10:20:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.125.188.120
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761560405; cv=none; b=EQsMIBhkTIWaKYb4nT2Dl8r+JF52jLkoIGxr/9eHixYtMdbms9HxvTTq+dPY0WRbK7C4WMprzzoq6EyBv9bOFDY1ndXliZiUdfvIFsM7vARbofEiUC+KjEoIG6o2gzc5Ghk+dv/se9EeGs8a8e+BjjXZ4JtDEHOyoH/dlE2kkvI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761560405; c=relaxed/simple;
	bh=DOWQ/qcWBC+vO1ciUHEKlchgMHh0M/GSCWHK15XJGWE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=KPErSKpAInDkiTgSba32sZuzrhQRdJz2P6An0t94QD5L0xW+ox9em1It1YdILFfseNGAfo5lUvN3IC3eQ4OiXkmSpQppO+qemUoJkWFMkrnNLbMK08Ajjr030dkfrvisOzBJD4dF6al+ukJukXfIHSWY6yyBmvySjCHIPa0QvoQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com; spf=pass smtp.mailfrom=canonical.com; dkim=pass (4096-bit key) header.d=canonical.com header.i=@canonical.com header.b=F1KwVCjL; arc=none smtp.client-ip=185.125.188.120
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canonical.com
Received: from Nerpa.home (2.general.phlin.uk.vpn [10.172.194.39])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-relay-canonical-0.canonical.com (Postfix) with ESMTPSA id 4E96040B76;
	Mon, 27 Oct 2025 09:57:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
	s=20251003; t=1761559044;
	bh=A3Gnxstn5KeGBqzT49890mWMte1P0ogRO19oSQNc3Rk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version;
	b=F1KwVCjL6yqOBpLZfGWjrBFwZzC8Fr900IBzwRp0nRhaykzvo70DHRL9GYaDGfsMH
	 0Niif+D3WWH9aI39Egw3OyRS7+0u+cH3MLuqRuNP8E784YHBtHwilhvWmghRaptTPi
	 Ff7PHJ0y3rfRRzqLXUpGRhhz98KMT5pgmoAVw/WYeBdQ4DXH2vxoJqMI1BW1SuvLjg
	 YqIb+nLMLe/Z7Lg3ImSiv+kqvp5dS1sH3Oope/MPi/Jip/eAfAz/5CJ5aU/zfN0J0w
	 Qn+6bNbk+h5RxT6CFKF5NWlFgd5HZSUZAKNQLa/6oCfPk9q0wHZjO5nwvb2rhc3jIP
	 5oyUI29Lfhe6tIb/+Ep8eVfVvMrE82RZHDsTUTMKc+E7/HekZnzU6Xfx5JeEAJWrR1
	 4FEIMqwCPAlJP428aU3HibCRikvSYe2Mj6gpt/v1+KismdfuhIvmevIQX/osg6ma5H
	 HEyZDd3MtOjKgtaZXpIxofwm/ALXM/RBvEWqceH853PXl9A+Dtzo50xUhUqiF1RWlk
	 z4kXeXSf0b2c6U7LpMJpOuJhYMwY78p7uPh2nk0uiB3spSenb3DY5g1Pz7o4GiiCpO
	 OM+Ks8t8iAo6MQpfCbHrtJp3Dg+iWsT4HexGZhgAyDboZtLs5O0lTA++ewNHDudAbg
	 dtSADPZIv2AZSP+cA4baVtys=
From: Po-Hsu Lin <po-hsu.lin@canonical.com>
To: netdev@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: po-hsu.lin@canonical.com,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	shuah@kernel.org,
	edoardo.canepa@canonical.com
Subject: [PATCH 0/1] selftests: net: use BASH for bareudp testing
Date: Mon, 27 Oct 2025 17:57:09 +0800
Message-ID: <20251027095710.2036108-1-po-hsu.lin@canonical.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The bareudp.sh script uses /bin/sh and it will load another lib.sh
BASH script at the very beginning.

But on some operating systems like Ubuntu, /bin/sh is actually pointed to
DASH, thus it will try to run BASH commands with DASH and consequently
leads to syntax issues.

This patch fixes syntax failures on systems where /bin/sh is not BASH by
explicitily using BASH for bareudp.sh.

Po-Hsu Lin (1):
  selftests: net: use BASH for bareudp testing

 tools/testing/selftests/net/bareudp.sh | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

-- 
2.34.1


