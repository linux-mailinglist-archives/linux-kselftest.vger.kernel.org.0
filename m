Return-Path: <linux-kselftest+bounces-15851-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D9FA1959C04
	for <lists+linux-kselftest@lfdr.de>; Wed, 21 Aug 2024 14:38:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1888F1C21978
	for <lists+linux-kselftest@lfdr.de>; Wed, 21 Aug 2024 12:38:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 50B3B19047D;
	Wed, 21 Aug 2024 12:37:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZhI8r38+"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC0EF18E757;
	Wed, 21 Aug 2024 12:37:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724243863; cv=none; b=ALXR7ral1kPgJRtR3sH8PIp6pHFKsIyUPRN4vmxdKhMhIJq7kOQLYze4Oes7ToEHHNdIAGVS7/yGGapSl8O3TTrA23DyUeQP3dwVmsYQ4ZKFJibPGlby/VAYqXHd1Crv4vDUb7ZvYPc2BBBmvs5bwc4sCIEQH9AZMnR4lprkAtw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724243863; c=relaxed/simple;
	bh=GfrU0gBKDw10a5XEEcr8vKGwPrwqvFoaujASnF5s00I=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=bBmro38TnyvW/0vQLfIWTmJoQvgxlcOmikB/w3nriy+ZC1bdc8S732J8NMTB1nWDHLfVHuLSzz7kNdYDLk1E4CnJbehlAeZ8HhsA0cG1TLZArHenrrsCTIaKLDb8P1275mOo6IsylWEdn1czEX5U81gM/lu5L6Wm7rhOWUiQSY4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZhI8r38+; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-1fc611a0f8cso51620715ad.2;
        Wed, 21 Aug 2024 05:37:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724243861; x=1724848661; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zpFUqVONNeKr7Nd0t5ps+L99zHRFJjZDaQO2WFhlXX0=;
        b=ZhI8r38+WJoaoP4WaQ5mAvfXa6xijt+0fbmCfk/Kc09cMWCz3kBFk5X4Yl7HWZ36rg
         l211TYOG4oRtT3aRIhlQbJls9iexdI1crdaIrIQRFQcvWkovCVjKTEAAW/eDZYGQiFNO
         ykRAwUjGSUdhcpf5QCeECLeWb+Pcw99d+RWXkyEmjEW+79wZJ0JhLv0FREo8BGDgOD6l
         BptTroPU7/Xa26qsV/chw0n89FQumaSwY7vhREvTno65AAcGNMiHxWESPmXhPPA4p17S
         W3Bp5G1smkqTRtKCK+RknRyy12vsh8Mx2XSOeJW17KRnwLVsGIkkVRzAIYs12NGv+b7L
         ZA2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724243861; x=1724848661;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zpFUqVONNeKr7Nd0t5ps+L99zHRFJjZDaQO2WFhlXX0=;
        b=wAUFCRoj8iUtwBWIgQ61sov7o1LYjLu2fj6YTjCSLIHlpypUuPBCQ+LEiODS8M3IUI
         OxGR5WoEkQOsZd5dg+10e6TJU+6wPIymbdgByixO+VqxA84HfutxWCsyIcIQlOzGkwBj
         i4adOpRmdTIb1Ut6tFokUkwGlcBOlxSR0u8q56G/cJVOYpgoDQVbeGlWCYNfxWdsnpix
         GUbUlJkoBtpGGtwZYLG4cobFBGIfkX84WcLyeRFewnCg8h9RXoo3Q8RRRTMsZSfZcbfI
         zsuO/vCNP5RcJJ8iJurvaknzAdrTjMIDxd3cMhjuOOlgRnno3xIsPF+stakDO9WyJlVt
         xtwQ==
X-Forwarded-Encrypted: i=1; AJvYcCUnFFNdjOgmdPslOh8P7E2mHnYafRZga/5T8HyTUVGhKEWLNAzgNM5HMH2z3EsogGWnoPD4v5iATN/GMTFjSoNb@vger.kernel.org, AJvYcCUvaCUCwXLl/3sp2kua9m3WvUWYePF5EO+7YkzE240UTUZQVHgwuZyThZskTvJcmz/2/kwXGVOTlvxjHhE=@vger.kernel.org, AJvYcCWu1x2Rjtfs63jNen/sLEuhpX7pkxXZlcn0KFQ5hdb2hcvpFB5S/GgWeW5/22zRNeMMGa9BnWSU@vger.kernel.org
X-Gm-Message-State: AOJu0YzTHHHvbxdU6cmxIfNs8S0cfNYMz89l7TZmSN7y70KzCMi6rWX6
	0tCPyzF9iJirdXJLK22dHgnf1/lAQaXo4eNaAGRjkYxNyXs1u0WMddQPSg==
X-Google-Smtp-Source: AGHT+IH5xLZnLZHlEg2smzboI8Xc89ciM7O8fQY1oAJB7HyL9YvKFUoGnz6gZbEHfqVKSIqi6IMXsw==
X-Received: by 2002:a17:903:228d:b0:1fc:f65:cd8a with SMTP id d9443c01a7336-20367d1394dmr23478295ad.18.1724243860953;
        Wed, 21 Aug 2024 05:37:40 -0700 (PDT)
Received: from dev0.. ([2405:201:6803:30b3:2256:a75d:4176:9e6a])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-201ffb8f0d6sm85023195ad.28.2024.08.21.05.37.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Aug 2024 05:37:40 -0700 (PDT)
From: Abhinav Jain <jain.abhinav177@gmail.com>
To: kuba@kernel.org
Cc: davem@davemloft.net,
	edumazet@google.com,
	jain.abhinav177@gmail.com,
	javier.carrasco.cruz@gmail.com,
	linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	netdev@vger.kernel.org,
	pabeni@redhat.com,
	shuah@kernel.org,
	skhan@linuxfoundation.org
Subject: Re: [PATCH v8 net-next 1/3] selftests: net: Create veth pair for testing in networkless kernel
Date: Wed, 21 Aug 2024 18:07:33 +0530
Message-Id: <20240821123733.109853-1-jain.abhinav177@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240820165006.4b6c8e44@kernel.org>
References: <20240820165006.4b6c8e44@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Tue, 20 Aug 2024 16:50:06 -0700, Jakub Kicinski wrote:
> On Mon, 19 Aug 2024 17:42:33 +0530 Abhinav Jain wrote:
> > +	echo "veth0" > "$TMP_LIST_NETDEV"
> > +	echo "veth1" >> "$TMP_LIST_NETDEV"
>
> Why test both ends? 
> Aren't we going to do the same exact test twice?

I presumed that we would want to run the interface up/down, setup and ethtool tests on both veth.
If this is not required, should I submit a v9 removing veth1 from the temp list?

Also, while sending v9, do I add the Review tag from Simon or it has to be reviewed again?

