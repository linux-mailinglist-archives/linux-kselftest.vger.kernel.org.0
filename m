Return-Path: <linux-kselftest+bounces-44842-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A137AC37A80
	for <lists+linux-kselftest@lfdr.de>; Wed, 05 Nov 2025 21:14:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 39D261896FE0
	for <lists+linux-kselftest@lfdr.de>; Wed,  5 Nov 2025 20:15:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F15933291C;
	Wed,  5 Nov 2025 20:14:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="gDUuJ/02"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-ej1-f47.google.com (mail-ej1-f47.google.com [209.85.218.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1363E3446A9
	for <linux-kselftest@vger.kernel.org>; Wed,  5 Nov 2025 20:14:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762373676; cv=none; b=StebkmibVCN+OZXKN7e7U8kT12l22JHELHCbItHZT/FF5LZm5pPw74LQJd5WEuGM/winoNhoIBdyDHrnqK08cj5lSq59UYBtHa2MM2RtoJEpRKbrPCD1BAPQG8l9GVrG3tb7Ev4iUQeGjXlDat+UHF8nZJMqu7EM+uUtspxdUW8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762373676; c=relaxed/simple;
	bh=FQzNj/iI21StuEtNBXSJB93avwyumsTpx259DhyFqdM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=QzK23EsaYgfHCE5JZNHqTuIAW+ubZhbpsxKgHH6yKMthd+i7G67la9baEKnRrJTDTvcB+wmlM8IhslDweVkMwfQe+e9+q92vVP1mWzG3rCWURMDhYOgzne4mTn66cqxPX+V2ONzNuCr19g4dU+TSGLwRBYeCWH1uHfAUmeYXnAY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=gDUuJ/02; arc=none smtp.client-ip=209.85.218.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-ej1-f47.google.com with SMTP id a640c23a62f3a-b5b823b4f3dso28532766b.3
        for <linux-kselftest@vger.kernel.org>; Wed, 05 Nov 2025 12:14:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1762373672; x=1762978472; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=6YOD+qBBkgg+BsuL1SBWq+3Z34YLCPMyV0Nnl+sTk3w=;
        b=gDUuJ/02vYyIgH7+jip+SvAFgZlGAZhJAvoSC6XhRPgbvjLFMk4otFzmw7laZ5gzmc
         icMR/h6bQUqZucrXoqSou/cptL7ThV6lcO5Tfio6cUmp7RnPoKUz70whgjdx1JAdiwNj
         aNuqfHkxG6dVhf5msmPfD99s5YUhip+HNIs9d2+nk41F3YiV918UvYhdpa19kePTiiDf
         SgwUM52q/7SBI+DllLta5VWv2C166YCEJifho6MyeqBt7YTONgj8Jae4YVrngWYqt8F4
         dYxyFQ6nZlqShgQqnbzMXdPu4RoiqMIJT33SkVfPXBO3SXV7LfbPK7lTKbFbITB3S+3m
         FO6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762373672; x=1762978472;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=6YOD+qBBkgg+BsuL1SBWq+3Z34YLCPMyV0Nnl+sTk3w=;
        b=JL9/cifKZeeKO7zrtiKbWPlmdwp/ExiabvMmhGiEuFQ3c+TfsyKVToMhOoejb9PXTa
         Zljc4CP2atXMd2nRw3WcHan0JYzvb+b9Xwm2W8hHxP/0Frizi/f8QCes5PT+Nl1WnlO2
         Dh5mkwfGE2yUueN67Yk6t2JnIkO9dhgOuYVRK58cxH8NzSF4T852Z/CRWqy/QSP71d7s
         Nq5253J2aGXkR8Qw0mbtIWt4rpygnzdsLmBebU0MlyKeDApaDRmwzGaqaJ8rNPxoAs2m
         PUVapBId5bmKoZEEK1vo5HcBIjhozFdSuOWqlfj7QlRru+WKRAPU6TG6czUKIkmwbOkg
         UciQ==
X-Forwarded-Encrypted: i=1; AJvYcCUmGhnrj57wt11TrghnzDuiROpgip76OTfiFISktpjtaWbHIEvhGUJRsrTlVVMci1vH3CVjMR3JWyfSxDeFu6U=@vger.kernel.org
X-Gm-Message-State: AOJu0YwRPYBPQljxpLC8/229Tsyt8xItOmNl0CCYj8WVwW0akK4ry1Ay
	MwXVjWWkgbQEqh6zOF2HowNVVbdTvseHHefZsQioL7F460deHIT/SINZlYC0Yk2Ety8=
X-Gm-Gg: ASbGncstr5wQ9yG0O5hBmfDa9CwkKjz6h4fPT5ukjvrutX8XHS3alpTwuiA88VoqOYq
	/g1ou5nCTwb3MAtYVFLPGFOxzjUaswjrDlG18Fpg/24ihPw5PbEvQaa4itkK9fRwLGYwMOjDPRr
	8IfVJmjORwFiQLUBJOR6zaq6K9G5OeZqZ1Bl96OIP/wRtwbEHZtmPbGhyr1Av20fiHbHfN09gOq
	BMmsWyOUoolSCNx24xULq0TXOA7OVptzJ36Vu6J1IIQVoq750dYwpEf3ASPhEFWUkbVz+kFUzJ7
	rMDhWgNAQ3Z9AvfvIs7aamBmVUCljVHbOKAhvxeDEBj/4JayIy9ZmrQgNQQL9iZiWjRVe6rlh5I
	NVs3S58MM86cOKxPy2tGiS45Gch/A3UuDKjkKgQrIxO2llZPzdjfFbxGvNB6Iuu+vEFf7NSYKpo
	VhifgrzVS7/wjN08iT998Gaw/opp+kiv3i3CX1uoI=
X-Google-Smtp-Source: AGHT+IHz4N+UDv5hA7YHGT9ZSBnETebYj3ZBuTUrybneyCPcbhb+U0L/RcjMsnvhLc9I+xf3WZ6OKw==
X-Received: by 2002:a17:907:9815:b0:b71:854:4e49 with SMTP id a640c23a62f3a-b72655edfabmr463264966b.56.1762373672395;
        Wed, 05 Nov 2025 12:14:32 -0800 (PST)
Received: from F15.localdomain ([121.167.230.140])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-29650967e11sm4101625ad.8.2025.11.05.12.14.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Nov 2025 12:14:31 -0800 (PST)
From: Hoyeon Lee <hoyeon.lee@suse.com>
To: ast@kernel.org,
	daniel@iogearbox.net,
	bpf@vger.kernel.org
Cc: Hoyeon Lee <hoyeon.lee@suse.com>,
	andrii@kernel.org,
	martin.lau@linux.dev,
	eddyz87@gmail.com,
	song@kernel.org,
	yonghong.song@linux.dev,
	john.fastabend@gmail.com,
	kpsingh@kernel.org,
	sdf@fomichev.me,
	haoluo@google.com,
	jolsa@kernel.org,
	shuah@kernel.org,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [bpf-next] selftests/bpf: refactor snprintf_btf test to use bpf_strncmp
Date: Thu,  6 Nov 2025 05:14:13 +0900
Message-ID: <20251105201415.227144-1-hoyeon.lee@suse.com>
X-Mailer: git-send-email 2.51.1
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The netif_receive_skb BPF program used in snprintf_btf test still uses
a custom __strncmp. This is unnecessary as the bpf_strncmp helper is
available and provides the same functionality.

This commit refactors the test to use the bpf_strncmp helper, removing
the redundant custom implementation.

Signed-off-by: Hoyeon Lee <hoyeon.lee@suse.com>
---
 .../selftests/bpf/progs/netif_receive_skb.c       | 15 +--------------
 1 file changed, 1 insertion(+), 14 deletions(-)

diff --git a/tools/testing/selftests/bpf/progs/netif_receive_skb.c b/tools/testing/selftests/bpf/progs/netif_receive_skb.c
index 9e067dcbf607..186b8c82b9e6 100644
--- a/tools/testing/selftests/bpf/progs/netif_receive_skb.c
+++ b/tools/testing/selftests/bpf/progs/netif_receive_skb.c
@@ -31,19 +31,6 @@ struct {
 	__type(value, char[STRSIZE]);
 } strdata SEC(".maps");
 
-static int __strncmp(const void *m1, const void *m2, size_t len)
-{
-	const unsigned char *s1 = m1;
-	const unsigned char *s2 = m2;
-	int i, delta = 0;
-
-	for (i = 0; i < len; i++) {
-		delta = s1[i] - s2[i];
-		if (delta || s1[i] == 0 || s2[i] == 0)
-			break;
-	}
-	return delta;
-}
 
 #if __has_builtin(__builtin_btf_type_id)
 #define	TEST_BTF(_str, _type, _flags, _expected, ...)			\
@@ -69,7 +56,7 @@ static int __strncmp(const void *m1, const void *m2, size_t len)
 				       &_ptr, sizeof(_ptr), _hflags);	\
 		if (ret)						\
 			break;						\
-		_cmp = __strncmp(_str, _expectedval, EXPECTED_STRSIZE);	\
+		_cmp = bpf_strncmp(_str, EXPECTED_STRSIZE, _expectedval); \
 		if (_cmp != 0) {					\
 			bpf_printk("(%d) got %s", _cmp, _str);		\
 			bpf_printk("(%d) expected %s", _cmp,		\
-- 
2.51.1


