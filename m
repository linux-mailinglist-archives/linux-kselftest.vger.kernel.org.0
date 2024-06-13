Return-Path: <linux-kselftest+bounces-11869-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C34FC90764B
	for <lists+linux-kselftest@lfdr.de>; Thu, 13 Jun 2024 17:15:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 667262842CF
	for <lists+linux-kselftest@lfdr.de>; Thu, 13 Jun 2024 15:15:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B991A149C44;
	Thu, 13 Jun 2024 15:15:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="UUCThmTd"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E7481494D0;
	Thu, 13 Jun 2024 15:15:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.227.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718291712; cv=none; b=GmGhnMu/HkHZ2A+/Jy7O0jjc9K/1WajVuyePXxV8uN7BSYbX+wDJXdmky2hBPghi4rqdmLStEttmWj/a5LOyeMly3ahbIAkNyJGeNzEoopf2USCrQe9qNGl9GdIi2+hgIIZQK9hPk4BDuinlSB7TUsK3+X3mX+eReLBrBBKkl4s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718291712; c=relaxed/simple;
	bh=3ozSPTlSEgTYrRu6Ije/gYJYhDxZM9wnwxZkXNIo93s=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=V7Yu6dXF431Q3hsgnHbZtJPVOjv//sRizpzafA0kFjUQQJ2JLe/1kEO0/pe1yf9LLSBTUT728UWdREWYmUEH3PFLILZ/d3qDMWoF1jROcFkDabE2bpLQnZhnEpDR6YiDtyAa6dgy7MLcpgHqvL6J51W5hdDYp4umhdZA5Gj9AS4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=UUCThmTd; arc=none smtp.client-ip=46.235.227.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1718291709;
	bh=3ozSPTlSEgTYrRu6Ije/gYJYhDxZM9wnwxZkXNIo93s=;
	h=From:Subject:Date:To:Cc:From;
	b=UUCThmTdzPIbMLr/IpB5mxKKfkA/O7KmzK4VF6Hv1GBu4JuUWkPHVnCmB+vnCPLub
	 igLGRvGl0LFc3dGnqJ3TFJfVjV+dtbZr0r/xlGLQt/CeLT//209TPeN+1GONijYXW0
	 hQja/LRZrxNHit93PdSFKJ4FqBCqp6RPQ1fMsX7qmQu8C3YtbjT3fRFpj8QYGSXPWl
	 ekxk0LXvyI0O7zrP3hxRNrhjjG3VTY+/tf+AkNBE48rHuYLESbyDJ88FoenNOmhwgs
	 rqX0IPGOoFzllDYwwFj+0GpnR8rIgRERrc/lDUysa9jnqKQPRxyELs+A5Q+KkqlJeR
	 f+gH+4OVAUr5w==
Received: from [192.168.1.250] (zone.collabora.co.uk [167.235.23.81])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: nfraprado)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id 6EAC4378143B;
	Thu, 13 Jun 2024 15:15:07 +0000 (UTC)
From: =?utf-8?q?N=C3=ADcolas_F=2E_R=2E_A=2E_Prado?= <nfraprado@collabora.com>
Subject: [PATCH 0/2] kselftest: devices: Allow running test on more
 platforms
Date: Thu, 13 Jun 2024 11:14:50 -0400
Message-Id: <20240613-kselftest-discoverable-probe-mt8195-kci-v1-0-7b396a9b032d@collabora.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-B4-Tracking: v=1; b=H4sIAOoMa2YC/x3NQQqDMBBA0avIrDuQDGraXqW4iMnYDlojmSAF8
 e4NLt/m/wOUs7DCszkg8y4qaa2wtwbCx69vRonVQIZa01vCWXmZCmvBKBrSztmPC+OW08j4LXf
 76HAOgsGTdS0510cDtbZlnuR3nV7Def4BuUDenHkAAAA=
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 Shuah Khan <shuah@kernel.org>
Cc: kernel@collabora.com, linux-usb@vger.kernel.org, 
 linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org, 
 kernelci@lists.linux.dev, 
 =?utf-8?q?N=C3=ADcolas_F=2E_R=2E_A=2E_Prado?= <nfraprado@collabora.com>
X-Mailer: b4 0.13.0

This series adds two new features required to be able to run the test on
more platforms on KernelCI.

The first patch adds a parameter to allow overriding the directory in
which the board files will be looked for. Since the board files are
hosted in a separate repository [1], this parameter allows overlaying
those files on the filesystem and passing the location to the test.

The second is needed for one platform in particular, MT8195, in which
the usb controllers are instanced from a two-level deep DT node that
doesn't allow unique matching based on the existing properties.

[1] https://github.com/kernelci/platform-test-parameters

Signed-off-by: Nícolas F. R. A. Prado <nfraprado@collabora.com>
---
Nícolas F. R. A. Prado (2):
      kselftest: devices: Allow specifying boards directory through parameter
      kselftest: devices: Add of-fullname-regex property

 .../selftests/devices/boards/google,spherion.yaml  |  4 +++
 .../selftests/devices/test_discoverable_devices.py | 37 +++++++++++++++++++++-
 2 files changed, 40 insertions(+), 1 deletion(-)
---
base-commit: d97496ca23a2d4ee80b7302849404859d9058bcd
change-id: 20240612-kselftest-discoverable-probe-mt8195-kci-ca21742776d0

Best regards,
-- 
Nícolas F. R. A. Prado <nfraprado@collabora.com>


