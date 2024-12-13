Return-Path: <linux-kselftest+bounces-23332-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F75E9F1292
	for <lists+linux-kselftest@lfdr.de>; Fri, 13 Dec 2024 17:46:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2EBBC164391
	for <lists+linux-kselftest@lfdr.de>; Fri, 13 Dec 2024 16:46:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C5CB1EF0B2;
	Fri, 13 Dec 2024 16:45:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XvMpnbV/"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-oo1-f53.google.com (mail-oo1-f53.google.com [209.85.161.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A48C21EB9FA;
	Fri, 13 Dec 2024 16:45:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734108317; cv=none; b=pDgxJ+K8PCgnbRbLqEcbMVku4U3QJwmgGreYNLtEUR/297s2YMMjJ7tawQf8cYiI1g6IjFznThn62PbKg46iDZ/XL4RpeoFiZuyRu5zm5KMk34XuqdMnlpVkRuLjQYOUw+7pRTIgQqU7jTPYCfHiGSRwKD9K8BsPTPXVUsJ5Ndw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734108317; c=relaxed/simple;
	bh=NPAZUXfChV3Ora7zPnwBI0ZZT7tSuwhUS6n6eLE6twA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=crIFH19+HfKTelZlSU7Efv5AHx8NYrNy9fiqiyRgFs5WvWKA7KGqslMiQHT624v1Qy8g+/4hsoBZ5bydp+TnmfCXYzsEr9efY5gpeJPHIsfGugGDsteZa6SAHbnaxZ2pChifxvseR+zpT5i8xCECPztlEoZU9ZtmDiG3zEfejf8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XvMpnbV/; arc=none smtp.client-ip=209.85.161.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oo1-f53.google.com with SMTP id 006d021491bc7-5f2da12248fso1490203eaf.1;
        Fri, 13 Dec 2024 08:45:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1734108313; x=1734713113; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=OwNuHyLKhIGlf1NAC+j01SXo3WPBAmH1vYDsVrnqpYQ=;
        b=XvMpnbV/1N6JUlCOmub4ngscFn7RZvf0J+mmIqq0VIK3EC6t92viIAhCR2fiDfsIyh
         iK23vZH80SdCdVxS30j6MMCwt3xtxBgXBjQ9FyPYNS1t/tHZb3XmdaVBc6j8mEgIwKaY
         a5/XpnwKGbY0dKX/MmwqyvyqjjfyKeFN06x99jfkRdXXyn/o3ypficjT/gM1NFeqR5a9
         8JiUpWhvrLutMizOSWufxlqvIUB2KcYQWWIeFitaNe4vURbsvH3OuSk7fjM4oLDK2iuS
         rLuWO5U44zpzfAdAtB302BjihFKcE5g1G9jmUZAuDWCjhvGUz48F2f+CEcRGZ2TcfM0d
         2oOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734108313; x=1734713113;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=OwNuHyLKhIGlf1NAC+j01SXo3WPBAmH1vYDsVrnqpYQ=;
        b=Iz6HmrF0W3hBfV8o3aI1gppJwyxbkDckE/W4i2jaN94jHXWsme+FWxj21lmUkN+eQ1
         pr1TAA3HP4+27tj10qHCSFl3vMef+ycipFl1Ga4hxyFmTGIW0a7pvQjkFWmfx3L3g5ni
         JbxMg454Schx8VgULXfdepSLZwqyKWYWYDptolAwSXHDuOpwP7hCY4gfYblD4vl9OJFX
         vO/cVRSryjToVbdH8FOlaQEpIjh9XhxLcuIUqCRw9ryyVAaaBJGTT7WjY7xB8efLZ98V
         V6G7cpsYhq0bFNFsoxIv2ZaBa4CM/CkFyLU9KwKSMBwLgayl9cD3yBxIfk7f+x+Qtml3
         3Uxw==
X-Forwarded-Encrypted: i=1; AJvYcCWjNezT1GVh7Pd8c0p1nMB2UeyWs/QWa8y1hNz42O0wsk2kEPpIGCj9/i8Mb88vSGYt1iVjSoOBht7ORBZvwlQQ@vger.kernel.org, AJvYcCX60HYipUmeG3C82q89UOHXs0ZBXwZdBvaibDEYDoUWbKh78cih7AKQTckTOxkz6RvhLZ+p7mIZftJAY3I=@vger.kernel.org
X-Gm-Message-State: AOJu0YwYcWjFLMzQccKZdW2soxMJ5jkZo7t+k/SmUkAJIQ1li6A7GheI
	NoilSBz+1Z16LlISP1JGRT7hSQixeIDTwhfDYJqq8/bpDHNtcItGmvgybMhxngMK6TKDapMjuZN
	fSq0wpdsuAsiM1MG51LU+0OOSxXY=
X-Gm-Gg: ASbGncsKOR5AjRp2X4KfK/4pmH5u8tpqZTX2Yl/Th5++COGsI3WX2wP37yYEEEnJanF
	bk12A9GSQ6LkNqiOJX2lTdnp9Vdgh7dxDWjKp5Fe20//4OyBYQPR7cfC5aK9ksLdPKfqd
X-Google-Smtp-Source: AGHT+IH5ADgyiFzZyO3c31OoGlIMIA6FqPa1UlyERbfGuj/pj1zNOeVEVig4Vm77wMEWiAuhx3DZ49RgowBEUKbS6S8=
X-Received: by 2002:a05:6870:ac90:b0:29a:ea3b:a68e with SMTP id
 586e51a60fabf-2a384fa112amr3853224fac.0.1734108313629; Fri, 13 Dec 2024
 08:45:13 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241211-b4-ovpn-v15-0-314e2cad0618@openvpn.net> <20241211-b4-ovpn-v15-2-314e2cad0618@openvpn.net>
In-Reply-To: <20241211-b4-ovpn-v15-2-314e2cad0618@openvpn.net>
From: Donald Hunter <donald.hunter@gmail.com>
Date: Fri, 13 Dec 2024 16:45:02 +0000
Message-ID: <CAD4GDZwT=V5-3aAb7eHah5fjLC3R1CrBCVA5kUFywb+ajOvzDg@mail.gmail.com>
Subject: Re: [PATCH net-next v15 02/22] ovpn: add basic netlink support
To: Antonio Quartulli <antonio@openvpn.net>
Cc: netdev@vger.kernel.org, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Shuah Khan <shuah@kernel.org>, 
	sd@queasysnail.net, ryazanov.s.a@gmail.com, 
	Andrew Lunn <andrew+netdev@lunn.ch>, Simon Horman <horms@kernel.org>, linux-kernel@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, Xiao Liang <shaw.leon@gmail.com>
Content-Type: text/plain; charset="UTF-8"

On Wed, 11 Dec 2024 at 21:32, Antonio Quartulli <antonio@openvpn.net> wrote:
>
> +        name: peer
> +        type: nest
> +        doc: |
> +          The peer object containing the attributed of interest for the specific

typo: attributes

> +          operation
> +        nested-attributes: peer

I also spotted that the doc: | construct results in extack messages
with embedded \n chars in the ynl cli:

./tools/net/ynl/cli.py --spec Documentation/netlink/specs/ovpn.yaml
--do peer-new --json '{"ifindex": 2 }'
Netlink error: Invalid argument
nl_len = 44 (28) nl_flags = 0x300 nl_type = 2
error: -22
extack: {'miss-type': 'peer', 'miss-type-doc': 'The peer object
containing the attributed of interest for the specific\noperation\n'}

We should probably sanitize the strings in the ynl cli, but you can
specify a flattened block comment in yaml by using the doc: >-
construct instead.

      -
        name: peer
        type: nest
        doc: >-
          The peer object containing the attributes of interest for the specific
          operation

extack: {'miss-type': 'peer', 'miss-type-doc': 'The peer object
containing the attributes of interest for the specific operation'}

Thanks,
Donald

