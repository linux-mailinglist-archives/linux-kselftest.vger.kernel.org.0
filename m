Return-Path: <linux-kselftest+bounces-25812-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E8A2A28544
	for <lists+linux-kselftest@lfdr.de>; Wed,  5 Feb 2025 09:04:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 06CBC168675
	for <lists+linux-kselftest@lfdr.de>; Wed,  5 Feb 2025 08:04:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AD368229B1C;
	Wed,  5 Feb 2025 08:04:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SN3q8xIP"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2900B2147E6;
	Wed,  5 Feb 2025 08:03:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738742640; cv=none; b=Wz5/NbV2A8ZxB3CMnWIOcv0v1awL/i7QJnZcduCTygM4qi/pxv+SmcM2ti7ZLmyWGpzYaNeCep1EVLJ2OjpCodRHQvAsugog7BX6wIPUSavyzLcHBXvbhTJm3g0bjy+ajap5zOkMhTQN4G2TuKTCLgimTKdk8w/tVRycnGCo/2o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738742640; c=relaxed/simple;
	bh=85wGPTLXhmpDm9za2v7pRqdsP8lKsxIYokXhP3co+ZY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=YtC6928EOvUHmNEfuyQrw0dZhuqBLwCIA2BozJL7PbKMzrcuO0zrZiFT9ZejbtyA1fc21HleYNQWHs1g10tPCCqIGizz9VOMOFnYnzjwGYI7pAPdvAPZmtUXjXvB7pBX1ZXlZxG295LfbICSkJwTI6a6NBckyxOuSYjzZNIQxgs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SN3q8xIP; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-21619108a6bso108573565ad.3;
        Wed, 05 Feb 2025 00:03:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1738742638; x=1739347438; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0kQ2itxvqbcuaBd7rib1vIkdIoFQupjIr21LbZKH5pI=;
        b=SN3q8xIPA5aLg4qRYgUcWb/YNEps9Gprr8vBXYJlyRo+JNRhc+1FLPx2TFOxsry6Dq
         AxzUfmlPCi+cSB7vn+5KW3VF5vDUpV66Hi/3BSrQugNPzwxy3Mv8LfpnmC923P3woLAQ
         VqBLw4naTrVtg9hrPd06rIdmVNz/z+pFKWgwRi0tyTpvHmVDSdUmqAwjTf7IsieL4FZD
         uB7yrXnxCA8834BNE7JzGQciIxUPbteMXeNRxOFkj6qAhSaRcso8q1u3cKWGQTBrCK4z
         z0HjUdmYAJDgbx02HfpRm5eV2T1lNaFzJ/IJwWpgsCoGLEdtIrhpdgMkIRKrwbo83Eh+
         PsGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738742638; x=1739347438;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0kQ2itxvqbcuaBd7rib1vIkdIoFQupjIr21LbZKH5pI=;
        b=QVyHtqatuG/zdZ4y3neWxRlbcVqK1CwRC+L803atN3SZXVcHnX6E5jXkBYz3DNuMLk
         Ic0Pmhs98SFCKKh6Qiaf3rajle8K814/CgKP0OdWV75e8TfB/e79ljok410XXatYNkRI
         1yQfPTV74sr7bewICQYre9kxylO3WVgOQtwjXxtGi+f07oBa76TD6hjOcgZnoF/kQqmx
         EIUnzCtPg0fli9jur5MyKLVbkOL927aix/f909I6+JuLiPx0bU2LZLRkAWfQgzXEKywZ
         4ie14Yk37fHvYrEAfy5UO8gVPqVTe9nrxlwX7lm8HrcKSCpvxgDrANK3BerW+uhtnpp7
         lzQg==
X-Forwarded-Encrypted: i=1; AJvYcCU+EfJmUxhajwjfRr24Ivjcvcd5KfUZcBNbUr+hJEx4VDysF0/8ifzx8Xt8Y05dHp6uKDKfpBF2HFxC4wekGIWr@vger.kernel.org, AJvYcCV6fqiMrXvvCf45Lg5Y9T2Ysx7cSrKoSwg0IzrygbmJ83jpWhY948Bo682w+/uk9UM5qq9l5BFYChPWHYo=@vger.kernel.org
X-Gm-Message-State: AOJu0YwNkDLPrP6Tj3a8Vr5wz+wXX8hNATGkQtbs6ZqKwnhJ7lD3HtoY
	BIdUyGdpwyOeEmGixv/ZAfJtz5vWjIEAOHSr5gowGWw8ExXkCkX4CVDV35UKaY4=
X-Gm-Gg: ASbGnct4PX0IdG6AhfFFf8XFlWwaS2leQSE0hgyxe6+YEH4Lu2HNL+uFKVa/UKyh7Jm
	rsdczcXKfbrF+4AJoSzVWIc0fV/urk2F33KFhADZBiQIf56BzuzEQtdWh1UYTSvRIwPuXQ1Cdo7
	QijLFz2i2NjNRhYoC/EzgaFALOoSGORSM311olfbHP9y0XeLfyPILjzg3Ef860HAYju1ikHSyIp
	qEGHhLokQDDZ+yjyMiAUYUbPk/c79j4wShwb5CaFECmTXPuZRE5sbs1QS0mviuHv+zhwiBm/dpx
	//2DKEEZyI03Q0ELmCx6MPiNxcXa18kjubE=
X-Google-Smtp-Source: AGHT+IG/JczhORvruVoXyh3kgJuQkm2+CRWIa1eODox8EC0B3/VO/SheYTU2PDY5u2wruk+hJ4AjMg==
X-Received: by 2002:a05:6a20:43ab:b0:1ed:a80e:932 with SMTP id adf61e73a8af0-1ede88ad49dmr4112847637.34.1738742638053;
        Wed, 05 Feb 2025 00:03:58 -0800 (PST)
Received: from fedora.dns.podman ([43.228.180.230])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-72fe6a18ae1sm11807039b3a.163.2025.02.05.00.03.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Feb 2025 00:03:57 -0800 (PST)
From: Hangbin Liu <liuhangbin@gmail.com>
To: netdev@vger.kernel.org
Cc: Jay Vosburgh <jv@jvosburgh.net>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Nikolay Aleksandrov <razor@blackwall.org>,
	Simon Horman <horms@kernel.org>,
	Jianbo Liu <jianbol@nvidia.com>,
	Boris Pismenny <borisp@nvidia.com>,
	Tariq Toukan <tariqt@nvidia.com>,
	Shuah Khan <shuah@kernel.org>,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Hangbin Liu <liuhangbin@gmail.com>
Subject: [PATCH net 2/2] selftests: bonding: fix incorrect mac address
Date: Wed,  5 Feb 2025 08:03:36 +0000
Message-ID: <20250205080336.2197369-3-liuhangbin@gmail.com>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20250205080336.2197369-1-liuhangbin@gmail.com>
References: <20250205080336.2197369-1-liuhangbin@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The correct mac address for NS target 2001:db8::254 is 33:33:ff:00:02:54,
not 33:33:00:00:02:54. The same with client maddress.

Fixes: 86fb6173d11e ("selftests: bonding: add ns multicast group testing")
Signed-off-by: Hangbin Liu <liuhangbin@gmail.com>
---
 tools/testing/selftests/drivers/net/bonding/bond_options.sh | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/tools/testing/selftests/drivers/net/bonding/bond_options.sh b/tools/testing/selftests/drivers/net/bonding/bond_options.sh
index edc56e2cc606..7bc148889ca7 100755
--- a/tools/testing/selftests/drivers/net/bonding/bond_options.sh
+++ b/tools/testing/selftests/drivers/net/bonding/bond_options.sh
@@ -11,8 +11,8 @@ ALL_TESTS="
 
 lib_dir=$(dirname "$0")
 source ${lib_dir}/bond_topo_3d1c.sh
-c_maddr="33:33:00:00:00:10"
-g_maddr="33:33:00:00:02:54"
+c_maddr="33:33:ff:00:00:10"
+g_maddr="33:33:ff:00:02:54"
 
 skip_prio()
 {
-- 
2.39.5 (Apple Git-154)


