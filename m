Return-Path: <linux-kselftest+bounces-18373-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6E40B9868B6
	for <lists+linux-kselftest@lfdr.de>; Wed, 25 Sep 2024 23:55:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 27184283490
	for <lists+linux-kselftest@lfdr.de>; Wed, 25 Sep 2024 21:55:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B99215DBA3;
	Wed, 25 Sep 2024 21:55:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="m7FXaWXw"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9215158DC3;
	Wed, 25 Sep 2024 21:55:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727301323; cv=none; b=X82lPn+okSDT3pksE6cEzXsJ9HHKw7UfAOb975vK5R684RX7NDt1mFSnlgSIc+YB0ZM+qR74Y/vc+7RHCQ0s9pgnvYcFwjPHO7+aesItSsELaQc9xA8uLPtcLwZ+YxcVHX++mE0sf0NvN7JRvrLOwdpkSle37hZIiV7gWcT32A4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727301323; c=relaxed/simple;
	bh=3VAYr/4iA33edkqdn2gdjNt0xqJCAUBS8pz6mX73zDg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=EWjm6fqNx8KbqhWOUHnfZjNo1LHbdbh0UjaVbhbBtUqG7L3uw6RgRBeTCtnQbxhQw61ONsUvZvlaliNONt/8PM3JevSZwMfLKiEcF3DBP0r6FT3ZX5vuh1a9zIavge3CLXBmbA0p58/vpvFyCgIuA+QyUDg0N+P6EaMpSpeKn20=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=m7FXaWXw; arc=none smtp.client-ip=209.85.221.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f44.google.com with SMTP id ffacd0b85a97d-374c180d123so163899f8f.3;
        Wed, 25 Sep 2024 14:55:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1727301320; x=1727906120; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=wXxvpKnLf6+pyhyXqE7O0MwMr9s4WW0ioNd1Ah2CRs0=;
        b=m7FXaWXwTgyLbhMMQmP4YD7jAjEw46XmYYWwJHSS6+WzYTfZKdUX7QK3ReEFUZBCne
         zcmBY0Za0qm11iLLrimo/0jNSD1MEu9v2pOTqHlmAAm2FcNYx9miE5P93T8XrVdEgEHr
         55PYJ6QjO5G6jo0ew4pMFhiWeIrnc46jKXclrVqT/L/9AqQJSJRTmfeNn3DUQusu3pRu
         3zq1t/stXtmPvULGyM8upyxtf6FJOzE+thrTU+3ktdtghrnmCw8sMRSTE9RVbGtjTsVh
         javJw+OihubhhghtsT7lqPz/uZ/HNCeTKx5fRFL//IvHPkzWXCsFipQ280A1WlilSsyV
         dP7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727301320; x=1727906120;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wXxvpKnLf6+pyhyXqE7O0MwMr9s4WW0ioNd1Ah2CRs0=;
        b=rI7MisSWIV46gjIzjzJwpIS4hxV6lXqdp5JthLF39mDQJCT3299dHZGEdz4s0qYWdn
         1SkQNbMVehaFTFvQ2hgs3FuW357FXw5byqLBqohKxjwmVZM3F6U5ZkWeb9KpVFirVNOP
         VobjUexc85VEIl1tdW3yAVd1YF2umyDY/Wt9w8sk8lqhLMhv186kIzZVuOY7AuN2/qr1
         GhR0YZHGd2HBP2Rwa09IXNak8IsVRcgQeQmTD1kVE4Y9jMEpzUlbtzgsrQostLJKooUS
         u0PVDQeNFBrP+PSSJgpPvcshE1794GlnpOaVu1zShHKhz0F13FZBQsSms5gnxbUvNb6j
         SC9g==
X-Forwarded-Encrypted: i=1; AJvYcCVVLzDrmZCSVAJeboA1vB659SGx77Bd2VscKZIVoEotgLPu1PzeqFomvFZSkc6dnnFM3OS2Hn/XHpg9fbA=@vger.kernel.org, AJvYcCX8ty5PkjuNhUjRIng2+EjjlBsA2JD2EYQ1OBdsIn9uSatS8eMywYZy7VIxYlgJS9XupKNBajK1MajoTA==@vger.kernel.org, AJvYcCXvA7Y+a6uDbmOf2Co/zMqUMa9UlP4ZYzIIYo6G9x8PY81MMxd1uXypSQD9pnpTd3LtPTRMWn9Z@vger.kernel.org
X-Gm-Message-State: AOJu0YwNmY3bABsnFfTIL90UTSYThicjAlDgTXhvcbEX4MMtn0S8omWc
	dme3etcAaAmRc7VYAA4LnyDg6HpJoqg6C2M84WNzQKewjs1rXdt6MrUzHGqQ
X-Google-Smtp-Source: AGHT+IED1n399IzIOXu7qBz5qhTw5yZNRJRJOn0+BAjBYHvO8fqOjDsKwBGJz5bqCNuTojaV0ZK0oA==
X-Received: by 2002:a5d:5083:0:b0:374:b31e:3b36 with SMTP id ffacd0b85a97d-37cc245c155mr2446205f8f.6.1727301319609;
        Wed, 25 Sep 2024 14:55:19 -0700 (PDT)
Received: from [127.0.1.1] (2a02-8389-41cf-e200-370b-ca26-d622-f1c3.cable.dynamic.v6.surfer.at. [2a02:8389:41cf:e200:370b:ca26:d622:f1c3])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-42e96a165fdsm29129385e9.34.2024.09.25.14.55.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Sep 2024 14:55:19 -0700 (PDT)
From: Javier Carrasco <javier.carrasco.cruz@gmail.com>
Date: Wed, 25 Sep 2024 23:55:11 +0200
Subject: [PATCH v3 1/5] selftests: core: add unshare_test to gitignore
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240925-selftests-gitignore-v3-1-9db896474170@gmail.com>
References: <20240925-selftests-gitignore-v3-0-9db896474170@gmail.com>
In-Reply-To: <20240925-selftests-gitignore-v3-0-9db896474170@gmail.com>
To: Shuah Khan <shuah@kernel.org>, "David S. Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, 
 Allison Henderson <allison.henderson@oracle.com>, 
 Eric Biederman <ebiederm@xmission.com>, Kees Cook <kees@kernel.org>
Cc: linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org, 
 netdev@vger.kernel.org, linux-rdma@vger.kernel.org, 
 rds-devel@oss.oracle.com, linux-mm@kvack.org, 
 Javier Carrasco <javier.carrasco.cruz@gmail.com>
X-Mailer: b4 0.14-dev
X-Developer-Signature: v=1; a=ed25519-sha256; t=1727301314; l=563;
 i=javier.carrasco.cruz@gmail.com; s=20240312; h=from:subject:message-id;
 bh=3VAYr/4iA33edkqdn2gdjNt0xqJCAUBS8pz6mX73zDg=;
 b=QAc+ZHfh+dqbqJCHsx0oZigYTuEqMseX/MCY2sXqOtq+O+B0MJ6uTI9xPDSjxWbKcliSUa8cM
 aYCATRsXDCmCjzuHqt3sgUAz0SgrEgiqRTC5g0aZBXpLygBLO0yT87p
X-Developer-Key: i=javier.carrasco.cruz@gmail.com; a=ed25519;
 pk=lzSIvIzMz0JhJrzLXI0HAdPwsNPSSmEn6RbS+PTS9aQ=

This executable is missing from the corresponding gitignore file.
Add unshare_test to the core gitignore list.

Signed-off-by: Javier Carrasco <javier.carrasco.cruz@gmail.com>
---
 tools/testing/selftests/core/.gitignore | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tools/testing/selftests/core/.gitignore b/tools/testing/selftests/core/.gitignore
index 6e6712ce5817..7999361992aa 100644
--- a/tools/testing/selftests/core/.gitignore
+++ b/tools/testing/selftests/core/.gitignore
@@ -1 +1,2 @@
 close_range_test
+unshare_test

-- 
2.43.0


