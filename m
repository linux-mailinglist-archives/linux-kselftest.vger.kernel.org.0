Return-Path: <linux-kselftest+bounces-7689-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E6BB8A0E4F
	for <lists+linux-kselftest@lfdr.de>; Thu, 11 Apr 2024 12:13:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5E1281C21861
	for <lists+linux-kselftest@lfdr.de>; Thu, 11 Apr 2024 10:13:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C94914659A;
	Thu, 11 Apr 2024 10:13:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iLpjHaTj"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D984A145B26;
	Thu, 11 Apr 2024 10:13:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712830402; cv=none; b=HWSMFFcx1DwCY+01G7DWyVRAJc3AqlwwIlvx/JhaF3YY6nZ5xRxXYmTJN/nm7EGgzFKJcmBYAeTYdaUKwQ6x/zuZJWX6loLq/YUgD15vf/NG6hgu5BczOM2/BDwl3tJ2wVN2dza7FfGhu3tXGHVUjUUdn8eVm+0cPYWW4aqZ8RA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712830402; c=relaxed/simple;
	bh=7jkWxiqDf4hXETQDU9Nt6va15AgnN1v7Sne4wEe1qHM=;
	h=From:To:Cc:Subject:In-Reply-To:Date:Message-ID:References:
	 MIME-Version:Content-Type; b=lZwlsvNYDolGd5eCkImZmYFkZmGIv2NyIC2Oijwqdij+uSTtEIj4TyjI/ShBfpgK0dzoxaZGg448RaQAmdloLfX30Wfruxtl0eCu0xfmly5/xzTGZ42LO5eynAMVpo7NDLz536ScF1J53lnFtKDUj7oxpjf/7kRV9Pg/aBNlIIc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iLpjHaTj; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-417db45fe01so2182005e9.1;
        Thu, 11 Apr 2024 03:13:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712830399; x=1713435199; darn=vger.kernel.org;
        h=mime-version:user-agent:references:message-id:date:in-reply-to
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=WE8U3zGdK8Nrqs01p6ZxRuiZLRiPxorjr1UvrNrkKTQ=;
        b=iLpjHaTjt7o4uuZrFjX+KjvHKaOIl0U6vTQU1MhA0UFODsE6lBNQ63qNAOGQFPyz8T
         K9JQSPy0pQeyT3IFZ8VzenDTgyLM4H04UmLqeIpfLHGXe8lKUWwScLua/gTJ0sUrLej6
         0jQowbREQqSCy07uYW3C2i0PuUv+pruk6X7nRotgDeBNFHhl7IoKUl7G3g7MGaCEfoWc
         gnpafCC9opzorR+v+eDAKTCcSUmraSHcOh+pqK3yb0E5spPWUIMqEkqaqtCJ8tNwq6oo
         WbMl/4448Qn9lcgYGdqyfzBGBh1OUvw4+ljF3ElyKZdRAs8dgBmAJmLVA5VDCSQvyD8Z
         SEgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712830399; x=1713435199;
        h=mime-version:user-agent:references:message-id:date:in-reply-to
         :subject:cc:to:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WE8U3zGdK8Nrqs01p6ZxRuiZLRiPxorjr1UvrNrkKTQ=;
        b=Y7EgFj/OKvUKoIiVD4cLmaRCXgaRp+UbIkizC2qTtqZzplZXFhnlSxoUXjz6aMCGnQ
         H//KV7ixtU4piqoKP+qx03XMPPNnTVhKi/FfKH/CSU5TAOfyUVjUHK/rdXZGJGVp7RlF
         IxzFYvLNJRJ7NMEGOt/CWG05CMVGVsjD8bkduLa4cZDT7CUZon9q+mjM7ssHJhYolF7N
         LYRuuN8bIIdiswV4hCr5SXDL776ActHkHQ6m8k/LqJ/tOmB+ACX4i+uyMi2svZ8q5bPI
         eQi7Lzv/rUh743TvS0fVIiZe4xO+78rZPmdU699a4GKxHiDwM4fl1XZKkYfKITGVPSSd
         ODdg==
X-Forwarded-Encrypted: i=1; AJvYcCW0woWRzfS/bogm4VBhAY/WLXs+y6jRd8G3GQahWhHFi5XJAR2em2s8k2akjbiVtKm3okkeVVe1oNYfkhJFbkjw/YtaDzu/fQCy3lifvKP+4SfB1JMdr5TBmyUlx3mC91Hu32O5G5dO
X-Gm-Message-State: AOJu0YybptRIUEZ6AAgip48eFBv1BWco6NVSnWTUFJrFyP19bZHHYhmp
	eqjMlUsYCrHzW5Ih2jco9xb1U7sTDvkSGI/3u129yLCXzP1eIDs0etYgz+J7
X-Google-Smtp-Source: AGHT+IHWPSKsfcJo5pCFGZX46mw1dAD9NlcMzCMOiKZSr0BpbdPE9asKlxbwORafP/jPftmuKaal+A==
X-Received: by 2002:a5d:4a51:0:b0:343:3542:b6aa with SMTP id v17-20020a5d4a51000000b003433542b6aamr3394460wrs.58.1712830399204;
        Thu, 11 Apr 2024 03:13:19 -0700 (PDT)
Received: from imac ([2a02:8010:60a0:0:9995:9b8b:815b:e336])
        by smtp.gmail.com with ESMTPSA id c18-20020a5d5292000000b00341b451a31asm1405488wrv.36.2024.04.11.03.13.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Apr 2024 03:13:18 -0700 (PDT)
From: Donald Hunter <donald.hunter@gmail.com>
To: Jakub Kicinski <kuba@kernel.org>
Cc: davem@davemloft.net,  netdev@vger.kernel.org,  edumazet@google.com,
  pabeni@redhat.com,  shuah@kernel.org,  petrm@nvidia.com,
  linux-kselftest@vger.kernel.org,  jiri@resnulli.us
Subject: Re: [PATCH net-next 2/6] tools: ynl: don't return None for dumps
In-Reply-To: <20240411012815.174400-3-kuba@kernel.org> (Jakub Kicinski's
	message of "Wed, 10 Apr 2024 18:28:11 -0700")
Date: Thu, 11 Apr 2024 11:12:46 +0100
Message-ID: <m24jc8i4wx.fsf@gmail.com>
References: <20240411012815.174400-1-kuba@kernel.org>
	<20240411012815.174400-3-kuba@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Jakub Kicinski <kuba@kernel.org> writes:

> YNL currently reports None for empty dump:
>
>  $ cli.py ...netdev.yaml --dump page-pool-get
>  None
>
> This doesn't matter for the CLI but when writing YNL based tests
> having to deal with either list or None is annoying. Limit the
> None conversion to non-dump ops:
>
>  $ cli.py ...netdev.yaml --dump page-pool-get
>  []

Makes sense and I'll need to update my --multi patch to retain this
behaviour.

Reviewed-by: Donald Hunter <donald.hunter@gmail.com>

> Signed-off-by: Jakub Kicinski <kuba@kernel.org>
> ---
> CC: donald.hunter@gmail.com
> CC: jiri@resnulli.us
> ---
>  tools/net/ynl/lib/ynl.py | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
>
> diff --git a/tools/net/ynl/lib/ynl.py b/tools/net/ynl/lib/ynl.py
> index 0ba5f6fb8747..a67f7b6fef92 100644
> --- a/tools/net/ynl/lib/ynl.py
> +++ b/tools/net/ynl/lib/ynl.py
> @@ -995,9 +995,11 @@ genl_family_name_to_id = None
>                      rsp_msg.update(self._decode_struct(decoded.raw, op.fixed_header))
>                  rsp.append(rsp_msg)
>  
> +        if dump:
> +            return rsp
>          if not rsp:
>              return None
> -        if not dump and len(rsp) == 1:
> +        if len(rsp) == 1:
>              return rsp[0]
>          return rsp

