Return-Path: <linux-kselftest+bounces-36806-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C964AFE39D
	for <lists+linux-kselftest@lfdr.de>; Wed,  9 Jul 2025 11:09:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 89F661C252E3
	for <lists+linux-kselftest@lfdr.de>; Wed,  9 Jul 2025 09:09:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 41C57285062;
	Wed,  9 Jul 2025 09:08:36 +0000 (UTC)
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-ed1-f50.google.com (mail-ed1-f50.google.com [209.85.208.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E665284662;
	Wed,  9 Jul 2025 09:08:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752052116; cv=none; b=HarPIfMHNdZpdTKIjFMj31lrv63qUlYph3Q2YKBoaoycX147AOVeAY+0pHcNRKdqtILouxlfYLtJOFjEosJd2BKCFijE9uWnMIEUVN9biJhcpmCpX6BcFRXCj87XsDNkcM9soqPHPkPwd2keJqDHYkxnzJWYv3dXdJiwjdBeVHQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752052116; c=relaxed/simple;
	bh=5e7Gu2hSYoF78NHOOQ4u3fblm9IpAmXxrCi48b0pb34=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=MO9HVXX7+ItQ2BcpFvL2fj1QO3AmGU/8gLUDkRNMfW1UrQPe+AlsFCerE9v6yKFTVSfLN0RbR59S6fLIOXjL74bTuyyC4wvSJttqYhDr9YZu1GLlyhaNxhS99OIVqtXbKwqO+KWs1BzJm8wj3p8qABzuYV0GykKANi0CqCUv6ds=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.208.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f50.google.com with SMTP id 4fb4d7f45d1cf-60c9d8a16e5so9820571a12.0;
        Wed, 09 Jul 2025 02:08:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752052113; x=1752656913;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Gaqp+BTPfvuWnqLQlzPe4IbE5DQFSHBJTK+OlPf0tvE=;
        b=gsgI6KUZCVbRERJcgNgU2G6sRWL+Tv/5HywNCDOk3CnRmlRVeDx+rxoO5/qAXyluHp
         9ZSq+jrubBGFwvp+JTY7zaClMOp5fyIOoZ5xffDJkctBFNEZOa1Iw5SGtDP706dlaIb0
         vmE8IVZPFr7thMtMQPbhs5hFqkGjXkntZj477PbeoWCtdDwOPqzcFDJ7gi75QKaSkfrh
         G51u9pG1TxLFiiURE7EDQB0tH8kIGqTO7Z1FpudAeFsANH1gMcBbI1O5Xk3jsJtD7H6Z
         14nKhiZTtXpQ2pAUCvQiISeTDTFNxAU/CocufZeXZIhAPMwmjSeGBiXEhqVxc6u96pD7
         wU3A==
X-Forwarded-Encrypted: i=1; AJvYcCUn1Fx4lVqVAkR+ttXHXry+reqRup95zv0t6MGkQAqN9Q6UHln/0q6d4GHQxvjRM5JvIrA=@vger.kernel.org, AJvYcCVRJKO8HSZ7KPmU/F3i/qTyehQeYMznJ5eTc6I3UtfHumPNViBWqVm5yxugqOX+zlUU9B8TFEp+ibcdtC6m9Rnw@vger.kernel.org, AJvYcCVWIw/nCb8eg5TbF3sykOXloScTbKpYa8afrA+EF0JN8DWm9yqedf2jsUpEHfaKVydN93PfXFSd@vger.kernel.org
X-Gm-Message-State: AOJu0YzUksF/b+QF+EKpsIKePWdF9Sut8hyVlOg1hey0klAUS4uQZOs5
	82Ldzca4b/dLg2+cQk74sra7r7YBhD/tE8zoM8IelVQSXTsPo3oibdRT
X-Gm-Gg: ASbGncvafkvj0+bcf90gpIBd31f8I5PpJbO8V8kiLYPy5dF63RIn81Wch0EznMHXKj/
	4c2stByrojFHizr9Wf2FvjNrVeWihnnLLO6FVly2LXmp39zg7nrXwDhaIAIruMyR/9tVxDol1Mq
	W8Kwo4zXX8AMIWJnsxRhmVZ4X4RSpkoc+Fei7IooCrzzO5bbWkQHKGw3ho7kSgb3rfTpx5m09tN
	qm5uGgwiutx1RYSnV6WtAo1T8Gwif5gtDNTJKy0e3MTgdE8wG2CY2RLLE/rDu1mmYVNDrwcY1uO
	/1EcYDy3lm4w0rGb7opqo97Jfop5a2XPpnEawyVl2NO2xYWEU7i9bg==
X-Google-Smtp-Source: AGHT+IHxOBQRhV3LQjYlKP2QRVe/mJ1jkHEpgMBTz4l2wSmjG32vKc1CypZqn3cCxXVOu3hprVAxXQ==
X-Received: by 2002:a17:906:6a03:b0:ae3:a3f7:ad8e with SMTP id a640c23a62f3a-ae6cf5e017cmr184962666b.25.1752052112359;
        Wed, 09 Jul 2025 02:08:32 -0700 (PDT)
Received: from localhost ([2a03:2880:30ff:74::])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ae3f6bb3af6sm1052753766b.185.2025.07.09.02.08.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Jul 2025 02:08:31 -0700 (PDT)
From: Breno Leitao <leitao@debian.org>
Date: Wed, 09 Jul 2025 02:08:16 -0700
Subject: [PATCH net-next v5 2/3] selftests: drv-net: Strip '@' prefix from
 bpftrace map keys
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250709-netpoll_test-v5-2-b3737895affe@debian.org>
References: <20250709-netpoll_test-v5-0-b3737895affe@debian.org>
In-Reply-To: <20250709-netpoll_test-v5-0-b3737895affe@debian.org>
To: Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Shuah Khan <shuah@kernel.org>, Simon Horman <horms@kernel.org>
Cc: linux-kernel@vger.kernel.org, netdev@vger.kernel.org, 
 linux-kselftest@vger.kernel.org, 
 Willem de Bruijn <willemdebruijn.kernel@gmail.com>, bpf@vger.kernel.org, 
 kernel-team@meta.com, Breno Leitao <leitao@debian.org>
X-Mailer: b4 0.15-dev-dd21f
X-Developer-Signature: v=1; a=openpgp-sha256; l=1053; i=leitao@debian.org;
 h=from:subject:message-id; bh=5e7Gu2hSYoF78NHOOQ4u3fblm9IpAmXxrCi48b0pb34=;
 b=owEBbQKS/ZANAwAIATWjk5/8eHdtAcsmYgBobjGLeLogJZU40OubI2N+HX+rpTwVsH2KBI8+q
 Vz8hEAt5g2JAjMEAAEIAB0WIQSshTmm6PRnAspKQ5s1o5Of/Hh3bQUCaG4xiwAKCRA1o5Of/Hh3
 bQheD/4juYvrnmo1L6yKWY7pfMQ2gVr4aZ8Fa9Bk+ZSx9poM3I/4EL6pdyxocKFoAyXldti/i0m
 29i1XY3KQFrKE66WQRPdzrABOs4CeuiZ2OzaARieIsuTNsGo90hwD87jLTcpwR1T0YvQH8yD9Jb
 x8DidB13plNwe7kq3cFNpUrgSTSxrQhEtuvEVGFc8KgF5WCXeXxfPYJefghmX6aDOw8rC4OO9oH
 vwH+haljrwnwTmV1Ob6gj0dLTx43H2tCAluNi3Cr6J2L3B/hyvMuLKaaUKr9rXnjK51jk+zJloN
 zUVvyiA6fcuknUY+T1RcjMJfaKS93aaHdDRGqYbR/ZrLCBKgoUwLOYvoiH3jSoCQ7y3h9yD06Dd
 DrAbah/8Wsz/VBXkMhH50FzW4KK8SjUooP7PjlKtVxnGGF3apCZVz0V8bFOWiy6Oqu2P0kjEglx
 2+qFgtBAFwe7RTeCuz4/DXzUU4uZSdMsiG9RwkENMzSCLQt8dlIDjLBCgFUEY34UIXHsxcnan1d
 oFigLBlzXdiP3BZqtvJNtou7eLFxXIyshcnlQEbyk7x9wRzVRN1XTSVPcIx7lYPQprXQQD9NSIo
 dRO8i01cHR0iYPqnc3KZ/k/CgaF7q1hgydFkUUOSuAXwrT3XwPfwwX4AyxyWMBSx+xnwrXHtZWC
 /fGJ0iWRq19hM0g==
X-Developer-Key: i=leitao@debian.org; a=openpgp;
 fpr=AC8539A6E8F46702CA4A439B35A3939FFC78776D

The '@' prefix in bpftrace map keys is specific to bpftrace and can be
safely removed when processing results. This patch modifies the bpftrace
utility to strip the '@' from map keys before storing them in the result
dictionary, making the keys more consistent with Python conventions.

Signed-off-by: Breno Leitao <leitao@debian.org>
---
 tools/testing/selftests/net/lib/py/utils.py | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/tools/testing/selftests/net/lib/py/utils.py b/tools/testing/selftests/net/lib/py/utils.py
index 760ccf6fccccc..33c23a928ed1d 100644
--- a/tools/testing/selftests/net/lib/py/utils.py
+++ b/tools/testing/selftests/net/lib/py/utils.py
@@ -213,6 +213,8 @@ def bpftrace(expr, json=None, ns=None, host=None, timeout=None):
             if one.get('type') != 'map':
                 continue
             for k, v in one["data"].items():
+                if k.startswith('@'):
+                    k = k.lstrip('@')
                 ret[k] = v
         return ret
     return cmd_obj

-- 
2.47.1


