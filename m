Return-Path: <linux-kselftest+bounces-11511-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 41A0390163D
	for <lists+linux-kselftest@lfdr.de>; Sun,  9 Jun 2024 15:28:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DEDBB28136C
	for <lists+linux-kselftest@lfdr.de>; Sun,  9 Jun 2024 13:28:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC49140879;
	Sun,  9 Jun 2024 13:28:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hm07olwf"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77E3F3EA98;
	Sun,  9 Jun 2024 13:28:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717939721; cv=none; b=KVxE9VZfD6RgLTPijtKB79l7V6v2GLWdLB2ZT8Qb+dEoZrxF5bvuYpoTD2WxKg/5kFqz5ozm5TIINUyS0KRWZgusdCc66dWPUcbg2VbwhtnJZT1Fzp3pPqXgUB7vnKNq59H0j3lxNNvLKj7NciUp5KPAMaZ/DcteejPbihiEpuU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717939721; c=relaxed/simple;
	bh=HjRthhA97Bz7lNeAY511f0m9k5cC/vd8hSnK6MJWYZ4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=EWCIPvjwOELMXOw/bGnOXcoUj90WKAp4vaftfLkAZPwJF1EoKLTj9gHmWjk+8OCxd4fmIR0qlceCitfmkgf4yZ3NfQlyzzaner4sTAgO+wFtoiZ7sVP/VVEp9ByRE9Ie4jr6Zwf5X1sxRBZEl1o/WV1dAwPVqUNSFEoITUR5wEQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hm07olwf; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-1f7149671c3so406055ad.1;
        Sun, 09 Jun 2024 06:28:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1717939720; x=1718544520; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HFWQoeFLGCKUUNrklzY1UKW+3++YeF3pYLivK/wT1sg=;
        b=hm07olwfnrsB/NJMrA6/k1c/T4zClu95vZrQZ42hE4yTq6wgLl1Ql9L5TLlAMOn4dV
         h+pFJox9bdy6ZoyvmwopmFaZkFWEWrjcuDcNk2av/QNvjyHogE/1t8WdNxEeFBkenITO
         oLkEG+HSC+A3m0uTuvDpeIIHdT7muofWDWodcFcFxCsjlGsAH6Wx2ahtpgvElisuOJde
         IdCmD7zJzYuKMAdRG/9/pkH+74ab1vQqca2zFMUIUYD4H2+TFkZl9UpkVYujNgv2VPFq
         ApfUirr3x6ZlcEHRi8sV9md4Mfk7VhkSjX+qMBbs8vlL9olhZwngbrcld6X+c8u4iRFz
         5yxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717939720; x=1718544520;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HFWQoeFLGCKUUNrklzY1UKW+3++YeF3pYLivK/wT1sg=;
        b=TIe3mLUo/DY3v8khGIMeG2c/bxa1jKRAmQfKsHdMtgzJaNCVEePDf7P64ExN4/t6wZ
         eQLj97flKn1bGPMI394RrPZrTThEx+QblDBTyUGGtbdElgkpdDw0rHskeghGr2QhQpv/
         38alVnAbDdBY+ie5jJW7iqRq2SP7k9/3IzKBBo0ZOaIZqytbyRZXsTo4OOchPbbob4lb
         L/KF9Jnaj9fDapfQDVC7K1+lhGrvVB5patz+/q7m8LjAZeOiHrj0us5M2BX10dRCTE/v
         1OCa/lJFNdaErOMOScmqG+G7aACpGygIobL8riNwc4kyCilTuYtJuHy5Fa1Pve1jYmQJ
         XwQw==
X-Forwarded-Encrypted: i=1; AJvYcCXhKR/LzIQ4ACmIpHd1JF5lpIM1tVjJwdr3Lzjg65f6KOxidBdxQY4O29TUduqGzUe/xD4F67v2++nI1k7isIm1XNHIaQOqgiZiZAiMw1/wu3TEr7jTihA7H3fBlKjO26w4n7bUPww3a3/DcX60UYBHIIsOVCZGRSPAjal8H7Dqb7y5seys
X-Gm-Message-State: AOJu0Yz4daei47zUgs4UWiD63rW6QSFU8nlApBcfQOjzjnfRuTRkDgNH
	7zeG1IFx3Ta7N1xmIAzPNGn5yNP5DAa0UYiRWi+Fm89aNgq95kJ5hqBD8YWu
X-Google-Smtp-Source: AGHT+IHk0nZO38SxWp2jyyxF8uWie9wwCPvhDQxa5lJYc2pSXMTE4gAUxpzxkvWy00CiLN0us2xudw==
X-Received: by 2002:a17:902:e842:b0:1f3:2f9c:bb72 with SMTP id d9443c01a7336-1f6d010ac6dmr110931455ad.5.1717939719662;
        Sun, 09 Jun 2024 06:28:39 -0700 (PDT)
Received: from dev0.. ([49.43.162.161])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1f6efa2a319sm28084215ad.108.2024.06.09.06.28.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 09 Jun 2024 06:28:39 -0700 (PDT)
From: Abhinav Jain <jain.abhinav177@gmail.com>
To: horms@kernel.org
Cc: davem@davemloft.net,
	edumazet@google.com,
	jain.abhinav177@gmail.com,
	javier.carrasco.cruz@gmail.com,
	kuba@kernel.org,
	linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	netdev@vger.kernel.org,
	pabeni@redhat.com,
	shuah@kernel.org,
	skhan@linuxfoundation.org
Subject: Re: [PATCH] selftests: net: Add on/off checks for network interface non fixed features
Date: Sun,  9 Jun 2024 13:28:32 +0000
Message-Id: <20240609132832.51890-1-jain.abhinav177@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240607180127.GG27689@kernel.org>
References: <20240607180127.GG27689@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Fri, 7 Jun 2024 19:01:27 +0100, Simon Horman wrote:

> Hi Abhinav,
>
> I suspect this will now only report a failure if tail fails,
> but ignore ethtool failures.

Hi Simon,

I agree, I missed this part earlier. After taking other suggestion
into account, we don't need this tail and I have removed it.

> Shellcheck warns that the above reads words rather than lines,
> and recommends using read instead.
>
> I think that is ok, because the construction reduces lines to single words.
> But it does seem a bit awkward to call grep, awk and sed for this.
>
> I wonder if the following construction nicer:
>
> while read -r FEATURE VALUE FIXED; do
> 	[ "$FEAT" != "Features" ] || continue # Skip "Features" line
> 	[ "$FIXED" != "[fixed]" ] || continue # Skip fixed features
> 	feature="${FEATURE%:*}"
> 	...
> done < "$TMP_ETHTOOL_FEATURES"

I have re-submitted a v2 of patch here keeping the above change:
https://lore.kernel.org/all/20240609132124.51683-1-jain.abhinav177@gmail.com/

Please review. Thank you. 

