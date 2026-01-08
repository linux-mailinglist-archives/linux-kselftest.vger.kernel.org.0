Return-Path: <linux-kselftest+bounces-48504-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id E34A1D0455E
	for <lists+linux-kselftest@lfdr.de>; Thu, 08 Jan 2026 17:25:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 5D49432C02C5
	for <lists+linux-kselftest@lfdr.de>; Thu,  8 Jan 2026 15:14:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB95647D952;
	Thu,  8 Jan 2026 12:19:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ja+7V8F1"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-qt1-f181.google.com (mail-qt1-f181.google.com [209.85.160.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27F46466FEE
	for <linux-kselftest@vger.kernel.org>; Thu,  8 Jan 2026 12:19:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767874752; cv=none; b=X9mw7HcYxdk42PzD1Z8HQLEzXbl6GfaeS/2NlTKm7b8qCWYeS9hlY/ffviCpnyJsrpAEAcI4dwpJK3xl+s3/7RY2dQqSs09ov1hJGv3i4Q2V4VRnq7EKEa3SOYGxI30/0QuHbuM+ocgQyxmftg/4DBO9/FUdwsBmmnBrnJ6O2fA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767874752; c=relaxed/simple;
	bh=XslR5Skl/tw/Xim8K72eczklMzvlOxARWwVTFZz2hyo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=NBmnB37nKot+LeTE1kq3KTEaEX0xPUQwwWOmlNDsEXcBSfVH9pX1Fy6goHGbw0ClgeqFSoxIvwmrXyqHf9yKZei6AYFxITTIfg64FWb7gDueNCDZ4ubqx0Pl/ymmGGxv0szwuyRwRqL5+j8VG5LRkuKait3E38kCbW2qRtppNu0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ja+7V8F1; arc=none smtp.client-ip=209.85.160.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f181.google.com with SMTP id d75a77b69052e-4f4a88e75a5so29180921cf.0
        for <linux-kselftest@vger.kernel.org>; Thu, 08 Jan 2026 04:19:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1767874746; x=1768479546; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XslR5Skl/tw/Xim8K72eczklMzvlOxARWwVTFZz2hyo=;
        b=ja+7V8F1ZwjWz5gIR9kXgeJQwqADgKnij+xGhHeSKOkbZ3j0fpqSXJgQwNFDUpSKHu
         BLRlwmWb5dG1rM6Sz97lQd8qG1LLDpxMRxJYaMGnmPnlptG5NZpECNAIr9Tm3qHE5hyY
         piUAzuG5yyotnME9cOrJQl6abmkEoDMJBDTvgWGMzgl/OE0W9gkeHApBotwro/H/ZKDs
         yL/HIYAMRAuDuFSAmVl2ueileIkRxaFoPFTmU+Q9KvU6xmU7xtRbJRglFTI+LTVlwgjV
         Jc3u+GQncx4lvYaL+FriQh4RoBG8qp0tuMoKbeqSCwslizSnn2sb1YoiVqWHZZy60zhk
         JhwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767874746; x=1768479546;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=XslR5Skl/tw/Xim8K72eczklMzvlOxARWwVTFZz2hyo=;
        b=vGp0+cgBjycyKeKRbBMOQeItB2qG1HI4nEYjzHUssY50LH/ihVT0xhg0Lgk+h9FCz+
         0yWfYAC9gJLku99+r4OVwdUZUWcU9ZhqQp++HoDzjUj+pz41PuzY+kwQHnh4qXGjTgYT
         nnRItkRrjKMhDKWwGI6ie3h76HYUq83HkgrGU0VWUF4jlQh719tXfgjwPX5o6XvKa0RX
         pFWdikBS05g/UFMnrPRkypObUal86e+tLObmps+fDPm9xCbmjRlUaPT2c7xR5VZ+iY35
         WJZwBTPCd9780ttdHFH4z5rjMTNspwZN0SIGfSlMqp6XZIrrVKrLqjVCHgfxNtcmcmfg
         4U8w==
X-Forwarded-Encrypted: i=1; AJvYcCXDnhJZbu4qJev8k9+PwH2f2ASPAEC4tYd+fcAeH+cxYGiLVSXpLfvlu4yqL2PENUe0qiyGemtXStt5usxBrBw=@vger.kernel.org
X-Gm-Message-State: AOJu0YwaCXsSS9TX9YYTUnyxYcxO02ZSLXm33Tf6gKkVJF2c/CuXhc96
	JlMbTAmvVLp1qQcN7FldPUg/V/GHktER+whvX+fmJaPiFGVMzOnRhEVUTZeF9u4uW9il0pE2pWr
	BcWST4ZdtrxxKKTTFCx1WCM7nEGcDjbEUX4ThV3KN
X-Gm-Gg: AY/fxX5Y2IRepANSi7xEUgQtf9Y4ggqHMtLmzKxHjaJsYB3xViA0kg74Aq9/OH+0xuP
	TfGZ8TjdHCqefOoRIVe/f75eZP94S2TZ4uCt2Tgtk3E3VjI5swgECgnd3FOpkvl85SqhJJ7hakP
	69wRl+ieClHum9P+oYGbzmr12SkRbK3YZBtYueJFVeOIc2YxeQELJq+ub+guWb+k7Fw66YeDJf4
	7X/sNhX4r1JcLUnJ3/wN8uvLKZwD0jOkvzjnlX2WCBlz+T6Uo30iFzGELwFvO/QznaBhvyYltWw
	guRq
X-Google-Smtp-Source: AGHT+IE6CBzyCrx4IFVvz/0AqM39PV6mvwh7lOn07b9ckEerO+EpyGAL7TIuu+rk4c57j55fgOdIw95rlnzvDdfaED8=
X-Received: by 2002:ac8:7f8c:0:b0:4e8:b2df:fe1f with SMTP id
 d75a77b69052e-4ffb487f955mr83824451cf.28.1767874745665; Thu, 08 Jan 2026
 04:19:05 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260103131028.10708-1-chia-yu.chang@nokia-bell-labs.com>
 <56f6f3dd-14a8-44e9-a13d-eeb0a27d81d2@redhat.com> <PAXPR07MB798456B62DBAC92A9F5915DAA385A@PAXPR07MB7984.eurprd07.prod.outlook.com>
 <9d64dd7e-273b-4627-ba0c-a3c8aab2dcb1@redhat.com>
In-Reply-To: <9d64dd7e-273b-4627-ba0c-a3c8aab2dcb1@redhat.com>
From: Eric Dumazet <edumazet@google.com>
Date: Thu, 8 Jan 2026 13:18:54 +0100
X-Gm-Features: AQt7F2pGmpHwQwLbaeD-dBc7rrFfr_O4l9u7b9jAwL-yY9Bn1sm999duNbFyyYY
Message-ID: <CANn89iKRAs86PVNAGKMUgE49phgZ2zpZU99rRkJq=cc_kNYf=Q@mail.gmail.com>
Subject: Re: [PATCH v7 net-next 00/13] AccECN protocol case handling series
To: Paolo Abeni <pabeni@redhat.com>
Cc: "Chia-Yu Chang (Nokia)" <chia-yu.chang@nokia-bell-labs.com>, 
	"parav@nvidia.com" <parav@nvidia.com>, "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>, 
	"corbet@lwn.net" <corbet@lwn.net>, "horms@kernel.org" <horms@kernel.org>, 
	"dsahern@kernel.org" <dsahern@kernel.org>, "kuniyu@google.com" <kuniyu@google.com>, 
	"bpf@vger.kernel.org" <bpf@vger.kernel.org>, "netdev@vger.kernel.org" <netdev@vger.kernel.org>, 
	"dave.taht@gmail.com" <dave.taht@gmail.com>, "jhs@mojatatu.com" <jhs@mojatatu.com>, 
	"kuba@kernel.org" <kuba@kernel.org>, "stephen@networkplumber.org" <stephen@networkplumber.org>, 
	"xiyou.wangcong@gmail.com" <xiyou.wangcong@gmail.com>, "jiri@resnulli.us" <jiri@resnulli.us>, 
	"davem@davemloft.net" <davem@davemloft.net>, "andrew+netdev@lunn.ch" <andrew+netdev@lunn.ch>, 
	"donald.hunter@gmail.com" <donald.hunter@gmail.com>, "ast@fiberby.net" <ast@fiberby.net>, 
	"liuhangbin@gmail.com" <liuhangbin@gmail.com>, "shuah@kernel.org" <shuah@kernel.org>, 
	"linux-kselftest@vger.kernel.org" <linux-kselftest@vger.kernel.org>, "ij@kernel.org" <ij@kernel.org>, 
	"ncardwell@google.com" <ncardwell@google.com>, 
	"Koen De Schepper (Nokia)" <koen.de_schepper@nokia-bell-labs.com>, 
	"g.white@cablelabs.com" <g.white@cablelabs.com>, 
	"ingemar.s.johansson@ericsson.com" <ingemar.s.johansson@ericsson.com>, 
	"mirja.kuehlewind@ericsson.com" <mirja.kuehlewind@ericsson.com>, cheshire <cheshire@apple.com>, 
	"rs.ietf@gmx.at" <rs.ietf@gmx.at>, 
	"Jason_Livingood@comcast.com" <Jason_Livingood@comcast.com>, Vidhi Goel <vidhi_goel@apple.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jan 8, 2026 at 1:05=E2=80=AFPM Paolo Abeni <pabeni@redhat.com> wrot=
e:
>
> On 1/8/26 9:47 AM, Chia-Yu Chang (Nokia) wrote:
> > Regarding the packetdrill cases for AccECN, shall I can include in this=
 patch series (v8) or is it suggested to submit them in a standalone series=
?
>
> IMHO can be in a separate series, mainly because this one is already
> quite big.
>
> /P
>

If possible, please send a packetdrill series _before_ adding more code.

I have been reluctant to review your changes, because there is no test.

