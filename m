Return-Path: <linux-kselftest+bounces-18353-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5EDE6986012
	for <lists+linux-kselftest@lfdr.de>; Wed, 25 Sep 2024 16:13:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 171411F26493
	for <lists+linux-kselftest@lfdr.de>; Wed, 25 Sep 2024 14:13:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3AE401BA89D;
	Wed, 25 Sep 2024 12:24:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="g+LYXM80"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-lj1-f177.google.com (mail-lj1-f177.google.com [209.85.208.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88D3C194C8B;
	Wed, 25 Sep 2024 12:24:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727267050; cv=none; b=q1JTuaK5pYlfe4DbWo+2rGAWtwKkpXbBtSdPpYm/zatADFThbKQNvLM1S7mOcI456EY29HLL3VbRXgSLtVFyWF2S+04mf3YWRlsIK0Deg3aQpp8fjFmY6xtoLiBR/35xWDIB3oipQUmcYGUn5MJBCxU9lJrWutOZv8jE5KvAEmY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727267050; c=relaxed/simple;
	bh=hI2BPsKn6Fb7xDapPbHxt54KAin5kF1lKUkbh087EgQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=agawH+pmPsWxD/NZKQDHmMkKPJzDBkPqQkpflDJREmqSs7t2e5zrTbBXIH1qHqnFPH5yVm64+EMy+CS+rVtNDN2BhwukpMBNHAFZxRHKCxvlSanXtnNV/vqcOBcla3JgxBfHBE28+aj/DzvZsL1nJKKYDP+dH5L2W5ga/W2nS4U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=g+LYXM80; arc=none smtp.client-ip=209.85.208.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f177.google.com with SMTP id 38308e7fff4ca-2f761461150so81318931fa.0;
        Wed, 25 Sep 2024 05:24:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1727267046; x=1727871846; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=0kNhACyHju1qZ/sENCdrWjPN9bm5n5NCjJOZx++DT6c=;
        b=g+LYXM80ZNjDpP0mK5OFKnFVJlp26vBeB66BHZiBqrdMJ9PQON9BvF49fclFDbuMel
         BNrubHiCWlTyER5eDUkxg7iIDAfeHzkw3qv3uK8ersQ3IB7hfZBPDKEZH+Cdp8PUxHwN
         f96K7p6VF4KruiHQcJZfGx367+5bP+7wtkidbwJEfeg/NdgPwRH1aXLH5iVCs7QJNqKh
         bJ6T4cUVKKn6pk9xZtrH+ZrWvsEH10nkracC9PE3HPKoCepkBM0S7emwAiio3jo986Qw
         dc5FfD+EuX4C/wqLnaCzNNwZbBGb0ioJ3k7TdL5H9UI/HYyTmeLyDgpnCniQQNOjnHG0
         Cy/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727267046; x=1727871846;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0kNhACyHju1qZ/sENCdrWjPN9bm5n5NCjJOZx++DT6c=;
        b=d25CfbmZLlAIkjYjbe2zGEiZxUTaUjlyDTpVLTuwaGk9reHOFCPv1tmiZHoZnHPRZj
         y82ZwjfKTP3KbKdj3WD1q+UAnhJFfUgvDhZwd0WvMEV032CYa7WuYQndHqE3Sdh6jnf1
         Wz0d5LLAMszYx6ZC4gJNI4G90pV/h9gJYRBos4GynTKEpfFq8czTjb5LYqMwkL1x7Tqz
         Mo6WgKSJIFknvAj8tAC0Ubs1trDssm659z513RVl+WU/4gcoQlfc3dw+1q3DjbIbe0mG
         O+FYtdpqjT/xBQyh8fh9QJk3jCAutcDjshrrlWGKlqFIEzHrMxMh4C6+1DyD3wg3g9kk
         2fiQ==
X-Forwarded-Encrypted: i=1; AJvYcCUfnZO/0GmOz8pSFKGy4P87SqY5aHkWkCdOrmlNZGv8G4D7wKOn4by2zubgBDO6CRh9Y7r5jdQ6@vger.kernel.org, AJvYcCVtZ+40A7pJs2f8TOUo3D64iyPthwaHN6yXApWB2D29nRXE1axb7nZLA0wSYfAamVppYEKhB1mOsQ2UMw==@vger.kernel.org, AJvYcCWobmEzayotrMp5HPfAJWe60QzK3zBOa+ue8grnE2S/XqlfhV5yqVw3S0rsiccQoXTZdCz815Py9r1IHbM=@vger.kernel.org
X-Gm-Message-State: AOJu0YywcWxuYf7KvM7DWTbdWUnSOiseqDO1DOY9jwWVgVGq1xDYNqN4
	ODoKM4yWtfQZyepR5JO/161+mMgsJDlznpiJ+EauT0ThxXzw/z+sSJb45Pdv
X-Google-Smtp-Source: AGHT+IFJuMvjAJkMioQv3dHkaulqKG9I12IidXBNPWfNu7Yi6cXgvUBjhDLAyrP/NpLPgYSynsgrKQ==
X-Received: by 2002:a2e:5152:0:b0:2f7:5049:160 with SMTP id 38308e7fff4ca-2f915fde784mr20030971fa.13.1727267046105;
        Wed, 25 Sep 2024 05:24:06 -0700 (PDT)
Received: from [127.0.1.1] (91-118-163-37.static.upcbusiness.at. [91.118.163.37])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a93930f8529sm204745566b.185.2024.09.25.05.24.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Sep 2024 05:24:05 -0700 (PDT)
From: Javier Carrasco <javier.carrasco.cruz@gmail.com>
Date: Wed, 25 Sep 2024 14:23:46 +0200
Subject: [PATCH v2 3/4] selftests: rds: add gitignore file for include.sh
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240925-selftests-gitignore-v2-3-bbbbdef21959@gmail.com>
References: <20240925-selftests-gitignore-v2-0-bbbbdef21959@gmail.com>
In-Reply-To: <20240925-selftests-gitignore-v2-0-bbbbdef21959@gmail.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1727267039; l=593;
 i=javier.carrasco.cruz@gmail.com; s=20240312; h=from:subject:message-id;
 bh=hI2BPsKn6Fb7xDapPbHxt54KAin5kF1lKUkbh087EgQ=;
 b=QPkIY+Y9iL6rJsPZE2UN8zmfudWo7sm8Nx10LgO3TzDVNrU2FVW1Qv3UB8CYhil9620UZJlQJ
 g+3CIu1c+c+CuZJSLtOcNbUZm87fsuYiBYSAmd6LZ3bT4Lvd3TdamQq
X-Developer-Key: i=javier.carrasco.cruz@gmail.com; a=ed25519;
 pk=lzSIvIzMz0JhJrzLXI0HAdPwsNPSSmEn6RbS+PTS9aQ=

The generated include.sh should be ignored by git. Create a new
gitignore and add the file to the list.

Reviewed-by: Allison Henderson <allison.henderson@oracle.com>
Signed-off-by: Javier Carrasco <javier.carrasco.cruz@gmail.com>
---
 tools/testing/selftests/net/rds/.gitignore | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tools/testing/selftests/net/rds/.gitignore b/tools/testing/selftests/net/rds/.gitignore
new file mode 100644
index 000000000000..1c6f04e2aa11
--- /dev/null
+++ b/tools/testing/selftests/net/rds/.gitignore
@@ -0,0 +1 @@
+include.sh

-- 
2.43.0


