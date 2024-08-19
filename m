Return-Path: <linux-kselftest+bounces-15639-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 417B8956A97
	for <lists+linux-kselftest@lfdr.de>; Mon, 19 Aug 2024 14:14:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 750A61C2252F
	for <lists+linux-kselftest@lfdr.de>; Mon, 19 Aug 2024 12:14:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 889CC16A94B;
	Mon, 19 Aug 2024 12:13:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JLn/1Tew"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pg1-f179.google.com (mail-pg1-f179.google.com [209.85.215.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 200F816A94A;
	Mon, 19 Aug 2024 12:13:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724069597; cv=none; b=mujyT45It6RMYcHretONxccmDB0AkmQfwjZtS98jxiBUlpCrRY+rHxHQBdRmV4GDV/3HuWxeUxv5hJEKNkLJCqtcbOOsZSbctp54Y+rKWd0UpzpoOHKb3XLlc9WYPGtUToSbyAkS1bE0dXVQPsWNQTKsBsHHsGjsak5faykLV2g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724069597; c=relaxed/simple;
	bh=Idk58CMtQw6QL14wA6jyRGnQvnolXk0rg/eWsDGch/o=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=LY185YyTaz6sEX0VqfKw0PAoxsb9gKnvwI3hI8nUBpwdfTZr8zs9dOvY3tNGLdtPtRdV6p55Gm6q8sqTHrbI+Dat3CNwP/ivlsqElAU46j29ikLexNNXwFJdMHgApRfx1aEC5j0UN6kUMK2kHw41GCXPc+mBNjmfsBLYpJD7AO4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JLn/1Tew; arc=none smtp.client-ip=209.85.215.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f179.google.com with SMTP id 41be03b00d2f7-7b8884631c4so1666998a12.2;
        Mon, 19 Aug 2024 05:13:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724069595; x=1724674395; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TBtjMaF6Lh1CJ5eS7HPTbSETrxh+4pmNI6Tav1CnXh4=;
        b=JLn/1TewzeTf+Su82zi/i226tPw0k3hIbdRjvMjkm1YH8fiHf1EOm/RUxCU6l5m7+L
         CJmAWy5wEzAA+EUJG+XUwoF3CiDZVtykFZnBMXO7jKIHJeoKLDySVmpRGQZu6LWYu84k
         t7T8jD7scFv97h9i8AD9LsFM0jfEMNqQnpwrtCrcUglyiF8W1ybw+zmF6G8aZe6we0qq
         usechS6WnTyhORxUSBOfS1Ri4gkIDKztt7oH2g/fPCgJNbaQQ1SgXIuuTTjgy5fb6+B6
         +1qIbcb5/UpyykeJQxTc4CRRAXvDztO0+8Hyu0Tim9A6MqjLe6pCcdS6CaveM1JfnFjn
         /c0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724069595; x=1724674395;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=TBtjMaF6Lh1CJ5eS7HPTbSETrxh+4pmNI6Tav1CnXh4=;
        b=bzr8jpetTPYfBIP6jtw32uyLuq+99AMQ5CgdpMGdIsCMRGDW7TAif9x0qq4S1RVp2o
         fn5v82nQyoVT3QGkrfQnqkI3CT1raRMJoZsKJtN5QkQazsgaiZDU22XoqjrGvB7D4ygb
         suYm2iugSQdmRN0OojbuEUrY6XvJiNjYTH7tRlnZ+eVpo+nnNNnGeZt2ZlSNg1BgD5WA
         ZFp60e9wWXmFUKJQRMdTWBciw478qzpNFv5Sxg8UNyvKS37Oz6VLOxt6w4g89E/EHCO5
         mI5GshyoLuPaqtkDxu+fy+N8MXVngOYzGNITZ7dstnFeG6Aygvmy1ANvb2f5ZnKyqDWY
         yTSw==
X-Forwarded-Encrypted: i=1; AJvYcCVBBZ1s0NU5mefe2vAsKmy1lQX1VuvGaS6ijeqHQslr8fwdy4khN1q1FsCZSinezmezaQODfs3gi/+vW7SViYrjlMYBYg0R6+3QlPBf0D3cNjXoR/cU/MCfkNHVrx+jFb7Ae/nAcMrszmvyiUt5NC7lqgqqXMdbwbv5YqVFxBnKDT9RVIjm
X-Gm-Message-State: AOJu0YzK8GRGzBUd7vO9ZcsPv/gRtB9qxMOcNz8NNQfEweRe2wwJU6ev
	Kqgh6Kb627pR2WAgpn3P3xuhUFsBNyo2L8N6B+h2KSBkHBGKjt/d
X-Google-Smtp-Source: AGHT+IH5fy0ECg5IjIz40piQ2k90appFhyqcltKwCDBQx4j90gYX363Jpu/ajT7cjGVEOL1jMQ38Hg==
X-Received: by 2002:a05:6a21:8cca:b0:1c0:f0f2:5ba6 with SMTP id adf61e73a8af0-1c904f7ec3bmr15046109637.5.1724069595309;
        Mon, 19 Aug 2024 05:13:15 -0700 (PDT)
Received: from dev0.. ([2405:201:6803:30b3:1f59:cb71:c749:d10f])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7127aef4136sm6501798b3a.100.2024.08.19.05.13.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Aug 2024 05:13:14 -0700 (PDT)
From: Abhinav Jain <jain.abhinav177@gmail.com>
To: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	shuah@kernel.org,
	netdev@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: skhan@linuxfoundation.org,
	javier.carrasco.cruz@gmail.com,
	Abhinav Jain <jain.abhinav177@gmail.com>
Subject: [PATCH v8 net-next 3/3] selftests: net: Use XFAIL for operations not supported by the driver
Date: Mon, 19 Aug 2024 17:42:35 +0530
Message-Id: <20240819121235.39514-4-jain.abhinav177@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240819121235.39514-1-jain.abhinav177@gmail.com>
References: <20240819121235.39514-1-jain.abhinav177@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Check if veth pair was created and if yes, xfail on setting IP address
logging an informational message.
Use XFAIL instead of SKIP for unsupported ethtool APIs.

Signed-off-by: Abhinav Jain <jain.abhinav177@gmail.com>
---
 tools/testing/selftests/net/netdevice.sh | 10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

diff --git a/tools/testing/selftests/net/netdevice.sh b/tools/testing/selftests/net/netdevice.sh
index 20febf9246ea..a596f0be9ace 100755
--- a/tools/testing/selftests/net/netdevice.sh
+++ b/tools/testing/selftests/net/netdevice.sh
@@ -67,8 +67,12 @@ kci_net_setup()
 		return $ksft_skip
 	fi
 
-	# TODO what ipaddr to set ? DHCP ?
-	echo "SKIP: $netdev: set IP address"
+	if [ "$veth_created" ]; then
+		echo "XFAIL: $netdev: set IP address unsupported for veth*"
+	else
+		# TODO what ipaddr to set ? DHCP ?
+		echo "SKIP: $netdev: set IP address"
+	fi
 	return $ksft_skip
 }
 
@@ -86,7 +90,7 @@ kci_netdev_ethtool_test()
 	ret=$?
 	if [ $ret -ne 0 ];then
 		if [ $ret -eq "$1" ];then
-			echo "SKIP: $netdev: ethtool $2 not supported"
+			echo "XFAIL: $netdev: ethtool $2 not supported"
 			return $ksft_skip
 		else
 			echo "FAIL: $netdev: ethtool $2"
-- 
2.34.1


