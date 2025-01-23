Return-Path: <linux-kselftest+bounces-25006-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BD082A1A547
	for <lists+linux-kselftest@lfdr.de>; Thu, 23 Jan 2025 14:54:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A568D1884284
	for <lists+linux-kselftest@lfdr.de>; Thu, 23 Jan 2025 13:54:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 330252101B3;
	Thu, 23 Jan 2025 13:54:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="DPyZUUbc"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 615271C9B97;
	Thu, 23 Jan 2025 13:54:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737640492; cv=none; b=JdFVNnD677RjVIqrn3HkQSz9+Mm3OWqfU7R8Umm46DpQRLkyoWJZ7kdhic9rG7zBbdl984uZUrJPDyehkrLtRNde98v5CDTXCeDV7M9ZHnN5/Adi0thuylQIIQLQ2a8AuUw7o4bgVZEmkZEtAffXqbNahEg0PfUv+JAHV85S8E4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737640492; c=relaxed/simple;
	bh=mpmROAOILsfpCKAiu41+m0laBpPufv8DP6gWUAS4uW8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=lSYh6dRbCEoORIq2Vs9LODRV7rbWkdIJB6aygBz8VjA0nxlND28xLMrGTlm8P/++i8aDmYEDZOci/YPDqlEe8i6V6J/H8OuKbBctH3DXu8R0rowcxhAT895Hqtljs44H8yzFyJMt7Yjp7DNsrE0xlDNkl+c3OOqBrqpcYU2hiYY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=DPyZUUbc; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1737640488;
	bh=mpmROAOILsfpCKAiu41+m0laBpPufv8DP6gWUAS4uW8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=DPyZUUbcYzAWqdb8utJjhFpwcaVRw1nwW1idgsmmpH3A+HX4gsUCit+v2MuF0VNKd
	 +S/VtL6K3PhqXCluWm9S4njwJyIO3cpRCmqHf4buWAEvuikD/xLub14RvOl9Sb4896
	 i39RmqYksu98oNVGzrgSiIvEYJdZImpJ7BWu+6dSEgnWQ+Wumknl240ifEK3L8lft+
	 FZER81gHfu10RmXi7VFEnLs13nIqsdmWENLp8iJkcObYwNdjhP1ShvF+CK3lwbIBCk
	 ByNKwZ9LbGOrt+OBiV/cSpT8HFfWiC9ONWDoNh0fIJ0fixoXTtjpESc0PFU0eDC2QO
	 lLwaVPIQOlReQ==
Received: from localhost.localdomain (unknown [171.76.86.251])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: vignesh)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id CAFA017E0FAC;
	Thu, 23 Jan 2025 14:54:31 +0100 (CET)
From: Vignesh Raman <vignesh.raman@collabora.com>
To: kernelci@lists.linux.dev
Cc: linuxtv-ci@linuxtv.org,
	dave.pigott@collabora.com,
	mripard@kernel.org,
	linux-kernel@vger.kernel.org,
	dri-devel@lists.freedesktop.org,
	linux-kselftest@vger.kernel.org,
	gustavo.padovan@collabora.com,
	pawiecz@collabora.com,
	spbnick@gmail.com,
	tales.aparecida@gmail.com,
	workflows@vger.kernel.org,
	skhan@linuxfoundation.org,
	kunit-dev@googlegroups.com,
	nfraprado@collabora.com,
	davidgow@google.com,
	cocci@inria.fr,
	Julia.Lawall@inria.fr,
	laura.nao@collabora.com,
	kernel@collabora.com,
	torvalds@linuxfoundation.org,
	gregkh@linuxfoundation.org,
	daniels@collabora.com,
	helen.koike@collabora.com,
	shreeya.patel@collabora.com,
	denys.f@collabora.com,
	nicolas.dufresne@collabora.com,
	louis.chauvet@bootlin.com,
	hamohammed.sa@gmail.com,
	melissa.srw@gmail.com,
	simona@ffwll.ch,
	airlied@gmail.com,
	Tim.Bird@sony.com,
	laurent.pinchart@ideasonboard.com,
	broonie@kernel.org,
	leobras.c@gmail.com,
	groeck@google.com,
	rdunlap@infradead.org,
	geert@linux-m68k.org,
	michel.daenzer@mailbox.org,
	sakari.ailus@iki.fi,
	jarkko@kernel.org
Subject: [PATCH v2 2/5] MAINTAINERS: Add an entry for ci automated testing
Date: Thu, 23 Jan 2025 19:23:32 +0530
Message-ID: <20250123135342.1468787-3-vignesh.raman@collabora.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250123135342.1468787-1-vignesh.raman@collabora.com>
References: <20250123135342.1468787-1-vignesh.raman@collabora.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add ci automated testing entry to MAINTAINERS to
clarify the maintainers.

Signed-off-by: Vignesh Raman <vignesh.raman@collabora.com>
---
 MAINTAINERS | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 33fe500bf3ae..874044e570f7 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -5473,6 +5473,15 @@ T:	git git://linuxtv.org/media.git
 F:	Documentation/devicetree/bindings/media/i2c/chrontel,ch7322.yaml
 F:	drivers/media/cec/i2c/ch7322.c
 
+CI AUTOMATED TESTING
+M:	Helen Koike <helen.koike@collabora.com>
+M:	Vignesh Raman <vignesh.raman@collabora.com>
+L:	kernelci@lists.linux.dev
+S:	Maintained
+T:	git https://github.com/kernelci/linux.git
+F:	Documentation/ci/
+F:	tools/ci/gitlab-ci/
+
 CIRRUS LOGIC AUDIO CODEC DRIVERS
 M:	David Rhodes <david.rhodes@cirrus.com>
 M:	Richard Fitzgerald <rf@opensource.cirrus.com>
-- 
2.43.0


