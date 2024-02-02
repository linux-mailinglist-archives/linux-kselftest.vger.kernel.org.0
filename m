Return-Path: <linux-kselftest+bounces-4029-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5DF8884764D
	for <lists+linux-kselftest@lfdr.de>; Fri,  2 Feb 2024 18:38:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C2C081F24672
	for <lists+linux-kselftest@lfdr.de>; Fri,  2 Feb 2024 17:38:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2ACFC14AD04;
	Fri,  2 Feb 2024 17:38:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="LKZBnlcR"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 647301482FA
	for <linux-kselftest@vger.kernel.org>; Fri,  2 Feb 2024 17:38:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706895500; cv=none; b=Me6XP2M0dLKR5tyYT9ti0D31aJFhUdMv8xux5PV1ftDiEAs7YgGWsaT/dh1qPzRfuAytu62J1UAPZGQZ55nMWPxysfl7BmolbV6Vf00hgchaRlDhNSuC0JoD+f0thEAhcG3uIJMjEGwF3VpdG5rrte9uM6UW3FkBYwgWXpsL+ZY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706895500; c=relaxed/simple;
	bh=IWJkGLm0O3qFP9qUzT4aQIiUJv/ogc60riN7vlY+6BQ=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Xsw0teWdZxHeLwJWhkrnttDg6FwGsURtDkOOWmV/qO5B/cVjzIY3vRrIky3PT+RlafZKb+pN7voV/s5DWX+ypc0ef02s6iZDYnasxL6ZiRpbBrgYr06N/sXfmka+GrdP67RGsiBPO7lwZt1mX+pvTwcc+/ZEiqt4rhiB8zwzO3Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=LKZBnlcR; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1706895497;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=IWJkGLm0O3qFP9qUzT4aQIiUJv/ogc60riN7vlY+6BQ=;
	b=LKZBnlcR0eg4e6/RNFDby/iaduwVDEx2QPNFKZ0TkUErLpihr365UBKzyd8kQg1vTJ2hUs
	+9TLWzTNqus1/oQiHMZ6+Ee1YR6Vim1/9Yxpmz7nSVqwfygeCcQ/3bKLCtQ3dBYT6Xweir
	5pdqijTIus+UjBgk9XF1k17UP1om1fw=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-121-YI2PTsd-PL-j7-iVtq9KvA-1; Fri, 02 Feb 2024 12:38:13 -0500
X-MC-Unique: YI2PTsd-PL-j7-iVtq9KvA-1
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-40e4303fceaso4506425e9.1
        for <linux-kselftest@vger.kernel.org>; Fri, 02 Feb 2024 09:38:13 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706895492; x=1707500292;
        h=mime-version:user-agent:content-transfer-encoding:autocrypt
         :references:in-reply-to:date:cc:to:from:subject:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=IWJkGLm0O3qFP9qUzT4aQIiUJv/ogc60riN7vlY+6BQ=;
        b=L8OsFlJnCWcl9rUmzD0x6pIQAfd/+0WjU0nGQEGznp67Ivj3lubCQtoTyycLwp6d7O
         WV8VTp18+q+nDS+nGd/GRi+chzgQo0QxLSerSwXlVOAnikM7+sbNjh7SWDNFid8Hs7aG
         wPllwykGfCg32wWIYjwfJyj3isiqkrC4c2DeZT4/OGNTTN38N67mQNZfWKbchaYp4Yfe
         twd50SpnnOS12bluQO5g/AS8BhiExfb6jybumTg4GqLTDQ06ZUihTguih32ypzLHwpSJ
         FxJbOSG475MuRRGq2EA38qRy/3sx3/L7cumws9DQGVt3IvWp6lg2ZsV7OXdxWDSNUTjm
         DuwQ==
X-Gm-Message-State: AOJu0YxIzP5NamX1sV7jsWRtpPFN8b6DzIb7kLWZIjWcKe2CNMag+Q97
	ZBJsMzoFUGp/2oJ9+S04MQ/r6DQYdSCLS8jctrJVYNxaVkzGu+rkdhK/01hyshQCaiWEjBbFgcq
	tm6U49O5PSqVOvkUskvU8P1YSDoOv6RV26ab660PMi+IkKasy/nX7DAfGwsW1LpQJBw==
X-Received: by 2002:a5d:574e:0:b0:33a:ff67:a5ad with SMTP id q14-20020a5d574e000000b0033aff67a5admr4497475wrw.1.1706895492640;
        Fri, 02 Feb 2024 09:38:12 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHqwabY6yrJ7nvkCdXefgezEgzqUIkwxeVHgtZJaD2IEJ4k/YWZZskVKGdcdjX3ElNQog6PhA==
X-Received: by 2002:a5d:574e:0:b0:33a:ff67:a5ad with SMTP id q14-20020a5d574e000000b0033aff67a5admr4497470wrw.1.1706895492326;
        Fri, 02 Feb 2024 09:38:12 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCVmJJk4XuOI19X21e7U9w8H1sTqALiK05gmDAQSLzWIlBFtaKxlBQFc+rIF7J4ql4TGYaozgJhI9HBnwZ1RNT7YNprAVb6HYiy4vMIkzXcScsIk3SWCCXrzo3I0cbYYk9d5zfHY/8mLAxataY8VXXySAaDPMAu9nGco+BQGN4h+x8sOMSMAaknEbTiRN36z/sONoW23pzwfsSR1Q5BcROy9Rsij6R0G9cUKri8wCiE1d0LQhhBMaDKhshJuRQ==
Received: from gerbillo.redhat.com (146-241-234-220.dyn.eolo.it. [146.241.234.220])
        by smtp.gmail.com with ESMTPSA id o6-20020a5d6486000000b0033b0992c364sm2391818wri.14.2024.02.02.09.38.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Feb 2024 09:38:11 -0800 (PST)
Message-ID: <977654460ba2ca52c19a8ca2e7350d2881b83a78.camel@redhat.com>
Subject: Re: [PATCH v2 net 2/4] selftests: net: fix setup_ns usage in
 rtnetlink.sh
From: Paolo Abeni <pabeni@redhat.com>
To: netdev@vger.kernel.org
Cc: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@google.com>,  Jakub Kicinski <kuba@kernel.org>, Shuah Khan
 <shuah@kernel.org>, Willem de Bruijn <willemb@google.com>, Florian Westphal
 <fw@strlen.de>, David Ahern <dsahern@gmail.com>,
 linux-kselftest@vger.kernel.org
Date: Fri, 02 Feb 2024 18:38:10 +0100
In-Reply-To: <6e7c937c8ff73ca52a21a4a536a13a76ec0173a8.1706812005.git.pabeni@redhat.com>
References: <cover.1706812005.git.pabeni@redhat.com>
	 <6e7c937c8ff73ca52a21a4a536a13a76ec0173a8.1706812005.git.pabeni@redhat.com>
Autocrypt: addr=pabeni@redhat.com; prefer-encrypt=mutual; keydata=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
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.50.3 (3.50.3-1.fc39) 
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Thu, 2024-02-01 at 19:42 +0100, Paolo Abeni wrote:
> The setup_ns helper marks the testns global variable as
> readonly. Later attempts to set such variable are unsuccessful,
> causing a couple test failures.
>=20
> Avoid completely the variable re-initialization and let the
> function access the global value.
>=20
> Fixes: ("selftests: rtnetlink: use setup_ns in bonding test")

The above should be:

Fixes: e9ce7ededf14 ("selftests: rtnetlink: use setup_ns in bonding test")




