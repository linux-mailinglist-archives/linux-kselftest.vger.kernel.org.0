Return-Path: <linux-kselftest+bounces-27517-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 14F5AA449FE
	for <lists+linux-kselftest@lfdr.de>; Tue, 25 Feb 2025 19:17:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 76F6717794F
	for <lists+linux-kselftest@lfdr.de>; Tue, 25 Feb 2025 18:14:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E463199FB0;
	Tue, 25 Feb 2025 18:14:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CLitZWsa"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-qv1-f52.google.com (mail-qv1-f52.google.com [209.85.219.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B67F610D;
	Tue, 25 Feb 2025 18:14:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740507286; cv=none; b=ghuDIhl6o4+SggyUSun2TPGqB45TIQfpy1HUVKmY39JK/a+IN7Ivh6cW0QuitlocKNfYB9s/nqBIE1Ny+dftsthhULDYiGAZRUTFjqSYdk9NGXMBHg+aRDdMyrWZ5+qgbEg18CVnHEzVU7HWjclMrc2ZaMSwD/Pq+tR49tqTmhk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740507286; c=relaxed/simple;
	bh=GW5jTXwKGESC3dgp5ePQ2pu7cawyAP5JV0KqR9Z3Fis=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 Mime-Version:Content-Type; b=QsL8iqZpY4vFYn6srLRzxFSSRnoJ9ocmXDCDfyx2nGHAMdD4GIyuMksIzvu4olXdVJgJrfP9Y/KZsIiKYP+V/mn/5ehwilQ6hWbhn6XekXguAe6qGLqs+Jfgwch9gFvRomROTYEI8v+pQLJ85KNzYq8KxtogPjUZJdo8sSf1aG4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CLitZWsa; arc=none smtp.client-ip=209.85.219.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f52.google.com with SMTP id 6a1803df08f44-6e69db792daso49977036d6.0;
        Tue, 25 Feb 2025 10:14:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740507283; x=1741112083; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Afk27/X80PuVJHRhAC5WWQqoXLETvNztAeuyGDXpES8=;
        b=CLitZWsa+MSG3TLuYnL/WLKupELTGNc9uNbr9+LGInBN13yhZNwHdAFYXbbxVox8tz
         eID5RyykFEGhJKgLvAvTEIxtxySCtFpNe2LtTzAdJpk9zhdInDe3X2hL2yoaJh0SpWn+
         Z/gHgmVRNYG7QEjIwPro7nX1MF3eJ/vg6wAHvAwj2CGZN0w3G67xK8ZFLBBI1Fu90/00
         Wu0x/1Hb1BSmqYFluQl4pXqAH0wW6QxqUO0L2L6sIP1aiV3JNKbUARNbsrMRwzh4IiCW
         V4Pj8WegQrk8A9L3hqoPztppkG6pHxifQsu4MdJjq3KNzdwx1s+cCcttT5t1SXsMgejd
         poxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740507283; x=1741112083;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=Afk27/X80PuVJHRhAC5WWQqoXLETvNztAeuyGDXpES8=;
        b=qTzRtVRWjFJROY+3aiZXUq8Dcbibm8euCc5dlq2uqcZrC3aNg8/ybU/y8xs8/00R30
         ggU9/hMTJ3b41yENTN6TCtYopJTdmiUHhLKI9MHLt2kUnP+CgoV6p9Nd+l/TTRZ/96iC
         ZuWx0Zu38la7KlqVd2BNBvVKDU//77Qy4FO6ALrkzr0tP2jgoShZ49fVwhsIH8K6wBhx
         RwIB+ZXyrGO/51x6pbr8sLLmu3X7b8NCiMb7OyhJOt6m07nWCfJHkh7LWTqxU0ySbs09
         MrinmtdoR58qAbaKbK0a8KYM6JNDNOcqXWktMPO5RFhPNtrbWGitUuQdwRFfOn/K/Xbl
         mlQA==
X-Forwarded-Encrypted: i=1; AJvYcCUNx9cGQgOL/AmrwKbRusnkD7K8Vu7eYw+Dwe350dKaAKyp+FCLuTgk6l2Tu6anIBSIVL7LUSed2FEDj1/Xk+mA@vger.kernel.org, AJvYcCUtu6MeWQOwp9Xerb9CgBef3zCQZ851WT3HLQNRKv9dzxj+vkL2P+kFKNeOUUiZHAKXdd3CW7SpaUSNXZ94@vger.kernel.org, AJvYcCXJNYFd7RstMUx0JSsxcvaR4BFQBeJS81d44aUcudcWDJDKc/T+T84ENlzuUw3Zn2Z8UOZkM+zB@vger.kernel.org, AJvYcCXoBT/QqpiayMrXCHoGDjBG3mNwiXBiLfRxOw/DFxiUi3Bm6QnlwvyXZcoAGLbe5mvptfs=@vger.kernel.org
X-Gm-Message-State: AOJu0YwN1V5+2jsIsrjPbCseG0KRuZgRXdIEpIzv6FxdSORRZ/YHoRea
	cbM+sjHpRWYPTidKTltBuiTSheiI0I+xHtsXkPMC/1casW6C9bWQ
X-Gm-Gg: ASbGncsjVmo45mJ4IEjLx82+I6gS+ztHHh4tlvloo8cO+qCopdJX+6EqkJ7WMkQnA8c
	yGGmHhiP1MJfj6bqE0NJWNQE+PIqx96nGams5xAIDJdhtuufuM5w7JO4EjIaiabatbrlIjHqPBj
	xcAo/yXIjY0lDax8DIZYBckAflUt9Gln7Q2he1RZJYY33vEUgG4h7GCWDOL4gLR94/Wb18qaHXl
	Dm/8eguqi2q0gghxt2R3rAbfcUJ8EbsymAbKYrNAwjWZF/+bvOraXM9IygpKMP3VZ8HGGxriywn
	m8SiKQse5rj4tyeiNAp6NpoG6iQFPG73TTs6RMa/Tpq5OJuFwxElVkXzBm7+MDsMrKFyJpKzQSB
	c3gE=
X-Google-Smtp-Source: AGHT+IExX7eM9fEZD7F0QtCwB+XhIqdpIe1EHNeoOZoYnsihPmyVx9XhY4575vLAyIyrtN6sLu19OQ==
X-Received: by 2002:a05:6214:21e9:b0:6e6:5aa2:4e4f with SMTP id 6a1803df08f44-6e6b01a9dcemr283977046d6.32.1740507283356;
        Tue, 25 Feb 2025 10:14:43 -0800 (PST)
Received: from localhost (234.207.85.34.bc.googleusercontent.com. [34.85.207.234])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6e87b06ddd4sm12063936d6.17.2025.02.25.10.14.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Feb 2025 10:14:42 -0800 (PST)
Date: Tue, 25 Feb 2025 13:14:42 -0500
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: Marcus Wichelmann <marcus.wichelmann@hetzner-cloud.de>, 
 Willem de Bruijn <willemdebruijn.kernel@gmail.com>, 
 netdev@vger.kernel.org, 
 linux-kernel@vger.kernel.org, 
 bpf@vger.kernel.org, 
 linux-kselftest@vger.kernel.org
Cc: jasowang@redhat.com, 
 andrew+netdev@lunn.ch, 
 davem@davemloft.net, 
 edumazet@google.com, 
 kuba@kernel.org, 
 pabeni@redhat.com, 
 andrii@kernel.org, 
 eddyz87@gmail.com, 
 mykolal@fb.com, 
 ast@kernel.org, 
 daniel@iogearbox.net, 
 martin.lau@linux.dev, 
 song@kernel.org, 
 yonghong.song@linux.dev, 
 john.fastabend@gmail.com, 
 kpsingh@kernel.org, 
 sdf@fomichev.me, 
 haoluo@google.com, 
 jolsa@kernel.org, 
 shuah@kernel.org, 
 hawk@kernel.org, 
 Willem de Bruijn <willemb@google.com>
Message-ID: <67be08921f167_25ccfc294bb@willemb.c.googlers.com.notmuch>
In-Reply-To: <e378ffb9-2424-4b09-b5fd-688f4f3d1556@hetzner-cloud.de>
References: <20250224152909.3911544-1-marcus.wichelmann@hetzner-cloud.de>
 <67bdd9e0c54d9_2474a12947d@willemb.c.googlers.com.notmuch>
 <e378ffb9-2424-4b09-b5fd-688f4f3d1556@hetzner-cloud.de>
Subject: Re: [PATCH bpf-next v3 0/6] XDP metadata support for tun driver
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit

Marcus Wichelmann wrote:
> Am 25.02.25 um 15:55 schrieb Willem de Bruijn:
> > Marcus Wichelmann wrote:
> >> [...]
> >>
> >> Signed-off-by: Marcus Wichelmann <marcus.wichelmann@hetzner-cloud.de>
> >> Acked-by: Jason Wang <jasowang@redhat.com>
> >> Reviewed-by: Willem de Bruijn <willemb@google.com>
> > 
> > Please don't add tags, unless a person has explicitly added them.
> > 
> > And they are only sticky when the code has not been changed since
> > they added them.
> > 
> > These are only in the cover letter, so not picked up. But for future
> > revisions and patches.
> 
> Oh, I'm sorry. I checked https://docs.kernel.org/process/submitting-patches.html
> but must have misunderstood it then.
> 
> To clarify:
> So these tags are limited to a single patch of the patch series and I should only
> carry them over, when the single patch where they were added to is re-sent in a
> follow-up patch series without changes?

That's right.



