Return-Path: <linux-kselftest+bounces-14134-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D2DE93ABE7
	for <lists+linux-kselftest@lfdr.de>; Wed, 24 Jul 2024 06:21:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D155828208E
	for <lists+linux-kselftest@lfdr.de>; Wed, 24 Jul 2024 04:21:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9CECA1C6B2;
	Wed, 24 Jul 2024 04:21:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BOoySf9K"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pj1-f51.google.com (mail-pj1-f51.google.com [209.85.216.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39D6129CA;
	Wed, 24 Jul 2024 04:21:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721794892; cv=none; b=or8eibN4Ck9h/Wy+fNXEb4qZTVgRORi2RTV1u80fAXHTuqV5Bf0qE/Av8KKkkV7JybxFRu/J3QAG3Higja55Dtk7LzxEhYE+B/JJxJFmexsAVEJdq6uvFTwAqRDjwaOlKR/xLaUUq9J1Nt1l1KsLYkZvaMWlLBdolr0wM7sDaaM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721794892; c=relaxed/simple;
	bh=pn7/GgcYFeTpdzJCNFalS7IHqJHr7xJ5ho6v8H0D+Is=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=bG5wbldnxxd+e7sfVcRewJ6v/h2VUdCdeCXlVV3vXYy1Sn1Vd7Ln7lw+gD8rLyt8W0qnEbKhTNxgWY4ndmkbHjdxjXBYZDiUDz4Df143fWH+c2kQTH4mwVdLIn/S0uLWDiXyPg/PfsTCiZyhznUuQUZMb0lgJBFzLRvxhroGnBE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BOoySf9K; arc=none smtp.client-ip=209.85.216.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f51.google.com with SMTP id 98e67ed59e1d1-2cb55ff1007so3260375a91.0;
        Tue, 23 Jul 2024 21:21:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1721794890; x=1722399690; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=0OcGOHEfL7V+MrPJ3mnfvHx5O5KEswa/t/OA6wujqSw=;
        b=BOoySf9KPm48MmsV3C2R8FRg2VLZzn8NEKI2bbDh1TstQAbwy9in0k0o1kXzYRwla3
         VpcUgz0NeYudiqMVwzvE+WW709dwthIwQ0V+fQkC/msT7cJ+u3aY0CAJQemIourhSGIr
         qYbyEiLnHlecYM0ou4GczTvWPHzK3/Jy+LsQI7TlPVFVNjB0DxHTpT27oFNwvoGWVrp/
         IbpfvKLcBWfwDo3HOxhxuzYcMoWsvLwYi12QHAGFJp2XNus19IcRjGBldP001Y9d9ch5
         4hX2wWoKcC3GogbLJxJfjOEQZzRg0pGlktSQCuPnJNnNLkIvz6aLAKRswMthtlo7SGZL
         /yGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721794890; x=1722399690;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=0OcGOHEfL7V+MrPJ3mnfvHx5O5KEswa/t/OA6wujqSw=;
        b=fJlu7STo2m1ZhlEke2IibWy2YukYLN9DsNpxLhP3Nd5HKXsWOhCtdG3Hn0YAYepAPP
         ZSlC+dyGcRoOmuC8JlWmsYymwuR3FS4p11KYq9+IbiwM/IBsVT6XhwDnjAJTHi0P3BWV
         hlJ8JJhfJOUIXfFbxJepkITi2zdYznnKInBt4FKhq4WQbOGZXwaZ7ooHOzTdUZkgxjy8
         wsnLtd45wKk8FZwuybUnj2dk/aY6y/CL6v57Q4wf/TBbHspxmdVxzVEC+XZHTRO77OtJ
         sm3j+3m4pO66E5nmiC+Rq23b4YlXB0qtHjtmySWAXaaCe5MbAscIxoYk8Zabbf6vNKpd
         yLVg==
X-Forwarded-Encrypted: i=1; AJvYcCW/rSkySmqKV7c96KYz1Li1XuJ0P4e64npnk0SnhIoNxwb9LvFhTUe/eee18JipLrARt+cludePX3Q8S8ouUgYndc8H7S0VbHPFUVmFomQeRjIZnIELjVYRsn7jzjsi7fhgBh/+Niw8ckzfPogo
X-Gm-Message-State: AOJu0Ywt/5NtUY2KEqRjRTiSqhAH1NKV6nZqLKpYZwWn/i6+el6MrUEH
	/0J263M2ptZlh8QUtNTyZ3GpwrC49uZU/AJLilkPsvxK41D99oAW
X-Google-Smtp-Source: AGHT+IGW1p+UtxCQWWGnJ8eFmsuWqf8FKkfy9nP5J2Dp/PJvWtjMT27noDOTuMaAI9eODGZpH3P72w==
X-Received: by 2002:a17:90b:1c85:b0:2c8:ea7b:8891 with SMTP id 98e67ed59e1d1-2cdaf55503fmr1884588a91.29.1721794890421;
        Tue, 23 Jul 2024 21:21:30 -0700 (PDT)
Received: from gmail.com ([24.130.68.0])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2cdb73a38f0sm513920a91.10.2024.07.23.21.21.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Jul 2024 21:21:30 -0700 (PDT)
Date: Tue, 23 Jul 2024 21:21:28 -0700
From: Chang Yu <marcus.yu.56@gmail.com>
To: ebiederm@xmission.com
Cc: kees@kernel.org, shuah@kernel.org, linux-mm@kvack.org,
	linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
	marcus.yu.56@gmail.com, chang.yu.56@protonmail.com,
	skhan@linuxfoundation.org
Subject: [PATCH] selftests/exec: Fix grammar in an error message.
Message-ID: <ZqCBSPFfMeghhRGQ@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Replace "not ... nor" in the error message with "neither ... nor".

Signed-off-by: Chang Yu <marcus.yu.56@gmail.com>
---
 tools/testing/selftests/exec/execveat.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/testing/selftests/exec/execveat.c b/tools/testing/selftests/exec/execveat.c
index 6418ded40bdd..071e03532cba 100644
--- a/tools/testing/selftests/exec/execveat.c
+++ b/tools/testing/selftests/exec/execveat.c
@@ -117,7 +117,7 @@ static int check_execveat_invoked_rc(int fd, const char *path, int flags,
 	}
 	if ((WEXITSTATUS(status) != expected_rc) &&
 	    (WEXITSTATUS(status) != expected_rc2)) {
-		ksft_print_msg("child %d exited with %d not %d nor %d\n",
+		ksft_print_msg("child %d exited with %d neither %d nor %d\n",
 			       child, WEXITSTATUS(status), expected_rc,
 			       expected_rc2);
 		ksft_test_result_fail("%s\n", test_name);
-- 
2.45.2


