Return-Path: <linux-kselftest+bounces-18351-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 12B0D98600B
	for <lists+linux-kselftest@lfdr.de>; Wed, 25 Sep 2024 16:13:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CA49A28AC84
	for <lists+linux-kselftest@lfdr.de>; Wed, 25 Sep 2024 14:13:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1ECAE193400;
	Wed, 25 Sep 2024 12:24:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Nph9J1Sx"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-lf1-f41.google.com (mail-lf1-f41.google.com [209.85.167.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43745192D93;
	Wed, 25 Sep 2024 12:24:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727267047; cv=none; b=TxN9asFeK9RojgRKcBn4R4q4kG0vxL3ilTfmXyaKvYgP+kmyOxLAEux19hljzPouuMDn2w5GbgJRRXiMV5ICUSe5hKN8Ug0vcTcqei/oI+ECJMgmjw2Wh3IT+9ilvKEvwtbwqB+kJG+StdlVFjjWDiiFhQu8E8ErewySVmxrtv0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727267047; c=relaxed/simple;
	bh=VAzLbhePXQTUa0RgQqWgt2vOIC7KZp5Sq9bUPalwf7E=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=CSZ6KLPXbyRr5aEeZujfcHF7PQOk2hpcp5NapvhHRZkDTSmCt7DIQcqRMueDGjzbyExPORDE+0gXyafEpyecibzpCm2XI2teSlislgzl95VAVzRqKTpD8nAiQdy+XcnDCLdvgymReVQJobwJco938wBZ+Ew8FwnbfWuMZHq57tw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Nph9J1Sx; arc=none smtp.client-ip=209.85.167.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f41.google.com with SMTP id 2adb3069b0e04-53659867cbdso9883054e87.3;
        Wed, 25 Sep 2024 05:24:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1727267043; x=1727871843; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=My/o3x2ZINOHGQf4kyCetcXoEUn+zJEi0VQbO3a2Fzs=;
        b=Nph9J1SxodklqkT/AbRtcT4lb5qZo0RsWWPqoJ+AmZRhhZrmPpnUdyCLl1V7qY663f
         Og7Mp4NVhMJwMGGYSxsr/KIHBo1szEdTf+SKVbszBv9PKvJU1VF6ocF7ZuJaGhOimj3U
         M/cUoeZny9mZWG6i7AGk1My80Slbt8cWxEBdKjTCTqHrU+B61R2FdU9crhVlvu9ZVjWc
         vFGc6HMnGLpFNtYoKib/xBBa7T02ZLPv8omu+YVSpFg7yDzppvC13qgE7WeG+/9s+IbU
         q2EPzqN7MWUiVUWnt4moPjLJwcMBfbz8+s1qPkbwrtkocL7RTf2uOq+vSkb0vzew+srg
         X8Qw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727267043; x=1727871843;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=My/o3x2ZINOHGQf4kyCetcXoEUn+zJEi0VQbO3a2Fzs=;
        b=l4ZaA+zz0Ol2l08YufrhdFnDTt0+mbwaWQnWcglKKi9MSnosddgXyCyBwYETx2S1mQ
         w3JbnvMHWpypDMWU4oBRJZUxbwxInV1O1bxr3J4/YAOAGiOe7EglIs7kOx89ciUjODFD
         +F6DK6zWiy7VYRZIavtcvXe1GeIRRI6Uj0VAc+51U5c6NHlfAnnQwNXO/kN/RmcoLG0w
         QL1f1RKD36b7OS0yYv0IBpX0K2ASsEBzlH2xxeHjePnMb8qESmiWJd5KKqF54FVUzagH
         7nOAbv61lEyu99vGcMdqfEXQJTH3XqiUJh1MLeE78oT80EVgulQPLcMq5LcLmQmPnSaQ
         Vfdg==
X-Forwarded-Encrypted: i=1; AJvYcCUTfp2KyhsO3xZv8lexI7O68+PyxIrblBgMboDc+YTkpXMJZUKA2E7YueD0hLMMs0qOouTowa5s@vger.kernel.org, AJvYcCV6VE15qV0GCenFyrq9naNWQvV2mkmA0ys36/GgAszP45Y2Rfw0aV7acqHXbiUr/JPM/j4dx6ty1mPb3w==@vger.kernel.org, AJvYcCXS4aFsmO/k2896XnnAEaKbVGxyomFTi8jAbca5nWq4Dl2MEJ5z2nNINAo+BxPzuPvJ/U2ppaKZ7XVBKIU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy1l4upUiUXWpAz0/Ei9pRTh8PMhS4S2lVH31a+tGEW7UgB33xr
	jhZXyiESrwLYClOLqtXYeTN1qmQ4qd/wl78lMQv1SY48ggF3ptXlRMtLa1Xj
X-Google-Smtp-Source: AGHT+IHcSyDQ7Osx2+bxCUyznm5CI/0dk0cR6wcm5H4kTaHPJDwtFbH2Rzoz8YNe91Bjjb4Q0ovkVg==
X-Received: by 2002:a05:6512:1385:b0:52c:e119:7f1 with SMTP id 2adb3069b0e04-53877566229mr2088007e87.51.1727267042514;
        Wed, 25 Sep 2024 05:24:02 -0700 (PDT)
Received: from [127.0.1.1] (91-118-163-37.static.upcbusiness.at. [91.118.163.37])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a93930f8529sm204745566b.185.2024.09.25.05.24.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Sep 2024 05:24:01 -0700 (PDT)
From: Javier Carrasco <javier.carrasco.cruz@gmail.com>
Date: Wed, 25 Sep 2024 14:23:44 +0200
Subject: [PATCH v2 1/4] selftests: add unshare_test and msg_oob to
 gitignore
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240925-selftests-gitignore-v2-1-bbbbdef21959@gmail.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1727267039; l=950;
 i=javier.carrasco.cruz@gmail.com; s=20240312; h=from:subject:message-id;
 bh=VAzLbhePXQTUa0RgQqWgt2vOIC7KZp5Sq9bUPalwf7E=;
 b=7L8lHYcSg7DYaL84lDJL7rjdxyIcbfH8hfHf/BDoqRoJ7ZSWbWdOaZIrjCd3su5EqbVORb9/Z
 3fKtFwk6SCjBJqHWPxTFyh/Q+oB7QZsRhP8edAftQOQOTCoJg9fXQlj
X-Developer-Key: i=javier.carrasco.cruz@gmail.com; a=ed25519;
 pk=lzSIvIzMz0JhJrzLXI0HAdPwsNPSSmEn6RbS+PTS9aQ=

These executables are missing from their corresponding gitignore files.
Add them to the lists.

Signed-off-by: Javier Carrasco <javier.carrasco.cruz@gmail.com>
---
 tools/testing/selftests/core/.gitignore | 1 +
 tools/testing/selftests/net/.gitignore  | 1 +
 2 files changed, 2 insertions(+)

diff --git a/tools/testing/selftests/core/.gitignore b/tools/testing/selftests/core/.gitignore
index 6e6712ce5817..7999361992aa 100644
--- a/tools/testing/selftests/core/.gitignore
+++ b/tools/testing/selftests/core/.gitignore
@@ -1 +1,2 @@
 close_range_test
+unshare_test
diff --git a/tools/testing/selftests/net/.gitignore b/tools/testing/selftests/net/.gitignore
index 1c04c780db66..9dcdff533414 100644
--- a/tools/testing/selftests/net/.gitignore
+++ b/tools/testing/selftests/net/.gitignore
@@ -17,6 +17,7 @@ ipv6_flowlabel
 ipv6_flowlabel_mgr
 log.txt
 msg_zerocopy
+msg_oob
 ncdevmem
 nettest
 psock_fanout

-- 
2.43.0


