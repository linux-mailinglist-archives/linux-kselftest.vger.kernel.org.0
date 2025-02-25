Return-Path: <linux-kselftest+bounces-27454-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 87AE0A4407F
	for <lists+linux-kselftest@lfdr.de>; Tue, 25 Feb 2025 14:19:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5C4C23B6695
	for <lists+linux-kselftest@lfdr.de>; Tue, 25 Feb 2025 13:13:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4ABBB2690F4;
	Tue, 25 Feb 2025 13:13:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="F5Vfqr2W"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BCA5F2690C8;
	Tue, 25 Feb 2025 13:13:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740489233; cv=none; b=agFNh5yGEsGEfyXLxCl5xiWh3eZeSff4DGGo6WKnIK7ZTfpAH8l28S590AL8TJOdfilqoHHb5wwT6oQ4fNmDL44aLQKdP94b5yDe74IpnCG8cQVxlrXMXYfUUAWVlu9E6uG6naEtRZVIo0r7OXvybUnZIcVQpA3brLtZb1f39Y8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740489233; c=relaxed/simple;
	bh=6kRCQ7fXHrIH6ekv/Ss52bOswcnen3yxj0SgzL/vpsg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QrT3TJVVhXfywiJECrwecXi/69PqJDDMzKKiTwJDTs7RjqT16uWIHqGEBDrV8Kx8ajFQnlnrXHCiRqqoE3j1hwPzMyZtkZ4Hn90Rrzcf1uMQsvgUKoyBA4cwo3ha2aV/c/Fo1gkfqC6MM4fE4BIqXEDg6sbU5jwfC19jmRslZDw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=F5Vfqr2W; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-22113560c57so27039565ad.2;
        Tue, 25 Feb 2025 05:13:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740489231; x=1741094031; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=z9TsjSO1IWqsIvdlcJcY3GR2q1JpemyZTlLz+DhSQuM=;
        b=F5Vfqr2W3zi6x8HIeLov93J6/jw5NBX3N1I/SSWeW67vU5sIg5HakhoIsPqn7+FW+P
         MlSVGtHrx7zZ43yK/r5CqGNQ0bImTkfXrk3S9rB6GfM9Eg6a5tGNDIsULoNgpfEZIOvq
         OwTgqzEEQJ/0BAcctM4q38mPSTKdoST+5kt3SJllpJhzjIuu9NFKF5ogH5mZxLmYLT6G
         w1hWWw8UYYTPvCfZcgq2gbHgxEdMSmr8pCVWEyBbHYdphJ59W74SglFn0Xml6MUEPAO0
         hU3NcWQGUnXE8SQvwWpyDYNKLmybaZwAPH7U++L/UVJPCsEkUSh7Fk73rah565I+cbDT
         oHBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740489231; x=1741094031;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=z9TsjSO1IWqsIvdlcJcY3GR2q1JpemyZTlLz+DhSQuM=;
        b=jxL+yxDBLYl3Qp/uRzFs9Ix3l2MjvEtHapysnAkhsSi+oADbCy4/VZsQkF01kSDK5e
         mS9+9jxuhQWfLbB/eMAht+PNZiROCFPJQJZXDr/NUUu5wOiKb3XpKVnIcWj+eBb6nhKg
         wRgtXtFuK/PKKc5X4Eb7l2QNWlpZDbArbCuOke3DuQuj1jKnS92IRybmYcDQ+KZM677b
         hp3uHuWvfkPQSOHLWBsQ99xcoRrRQX+e8PhZFE1WqeiMC+6MdmsWphCjOPhSYg5gJ8bA
         pW4GiAcUo5RyymGImfqms+/nJu/CGGdTC9SUYvD5IRdphsLkvh9CH6B8d7UuRUuWdiZ7
         y4Ww==
X-Forwarded-Encrypted: i=1; AJvYcCUiLup6UKJOsPYYTMrWnRP5+kgsVnTiFRErCuL7UzUTOVm++qmuN9DA0eUZPh+NLmk7pcqw0HDH+ZcG04c=@vger.kernel.org, AJvYcCWxddEzxUw79qPJepphbJSO8NieHc7KyWy2s+RwnrAJSgHMJcUU2ORwpLBfOj2mpQoU+wy8WUEPEvWbcbuyuiWz@vger.kernel.org
X-Gm-Message-State: AOJu0YyMvjpC6IsQs3MWBaouLwyDiTRfg5hKE3inV5LKFA3RIZM+Nawl
	UwmcBVoqGXcjzfZ2zCXN7tF15pz0mbi7LKjjzGA+TD/2vhv5R4SYlKWwBZkx6FG6kw==
X-Gm-Gg: ASbGncuX4sFjhP6Jh4SNqcoqyf2jZfFYkNTFcVNipCr+B/TIOaamYAgbF/lRXWOVCQv
	090LjyCqW/udh76XlMt8Z8FVrkpLUnc+t52InDcd6Mbuo7tpy6FJUhFITIzSaKQB2fYYofph+rE
	YzP7j9iVT0FyZZPg4MSCrNpeiZTNvEbGCU+QqN3Q3uQOMGHHwuQJiGqP1A6pXkIlMbtnF0bs5Tx
	Z9VQh9IqX7wBLMCLknvJb59FvACUUvfkRf9B6fEQVPE4Y+WfnxMAWqbpbsnCAxrVgDBp4LuXQEe
	qSvV1w0U6YR69EtBVqBV6PEvQhHGrsE=
X-Google-Smtp-Source: AGHT+IHJeOQlK9PS9RNyAPhLNtr0dg5YGqS2UGl7RUfoXHxhWKx8lHHwKT7XMi/jaVu93pbVEFfEkw==
X-Received: by 2002:a17:903:2282:b0:216:644f:bc0e with SMTP id d9443c01a7336-221a10dddbbmr308706845ad.24.1740489230926;
        Tue, 25 Feb 2025 05:13:50 -0800 (PST)
Received: from fedora ([43.228.180.230])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2230a092ce6sm13476975ad.127.2025.02.25.05.13.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Feb 2025 05:13:50 -0800 (PST)
Date: Tue, 25 Feb 2025 13:13:43 +0000
From: Hangbin Liu <liuhangbin@gmail.com>
To: Nikolay Aleksandrov <razor@blackwall.org>
Cc: netdev@vger.kernel.org, Jay Vosburgh <jv@jvosburgh.net>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>, Shuah Khan <shuah@kernel.org>,
	Tariq Toukan <tariqt@nvidia.com>, Jianbo Liu <jianbol@nvidia.com>,
	Jarod Wilson <jarod@redhat.com>,
	Steffen Klassert <steffen.klassert@secunet.com>,
	Cosmin Ratiu <cratiu@nvidia.com>, linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCHv2 net 1/3] bonding: move mutex lock to a work queue for
 XFRM GC tasks
Message-ID: <Z73CBzgTVucuOMMb@fedora>
References: <20250225094049.20142-1-liuhangbin@gmail.com>
 <20250225094049.20142-2-liuhangbin@gmail.com>
 <a658145a-df99-4c79-92a2-0f67dd5c157b@blackwall.org>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a658145a-df99-4c79-92a2-0f67dd5c157b@blackwall.org>

On Tue, Feb 25, 2025 at 01:05:24PM +0200, Nikolay Aleksandrov wrote:
> > @@ -592,15 +611,17 @@ static void bond_ipsec_del_sa(struct xfrm_state *xs)
> >  	real_dev->xfrmdev_ops->xdo_dev_state_delete(xs);
> >  out:
> >  	netdev_put(real_dev, &tracker);
> > -	mutex_lock(&bond->ipsec_lock);
> > -	list_for_each_entry(ipsec, &bond->ipsec_list, list) {
> > -		if (ipsec->xs == xs) {
> > -			list_del(&ipsec->list);
> > -			kfree(ipsec);
> > -			break;
> > -		}
> > -	}
> > -	mutex_unlock(&bond->ipsec_lock);
> > +
> > +	xfrm_work = kmalloc(sizeof(*xfrm_work), GFP_ATOMIC);
> > +	if (!xfrm_work)
> > +		return;
> > +
> 
> What happens if this allocation fails? I think you'll leak memory and
> potentially call the xdo_dev callbacks for this xs again because it's
> still in the list. Also this xfrm_work memory doesn't get freed anywhere, so
> you're leaking it as well.

Yes, I thought this too simply and forgot free the memory.
> 
> Perhaps you can do this allocation in add_sa, it seems you can sleep
> there and potentially return an error if it fails, so this can never
> fail later. You'll have to be careful with the freeing dance though.

Hmm, if we allocation this in add_sa, how to we get the xfrm_work
in del_sa? Add the xfrm_work to another list will need to sleep again
to find it out in del_sa.

> Alternatively, make the work a part of struct bond so it doesn't need
> memory management, but then you need a mechanism to queue these items (e.g.
> a separate list with a spinlock) and would have more complexity with freeing
> in parallel.

I used a dealy work queue in bond for my draft patch. As you said,
it need another list to queue the xs. And during the gc works, we need
to use spinlock again to get the xs out...

> 
> > +	INIT_WORK(&xfrm_work->work, bond_xfrm_state_gc_work);
> > +	xfrm_work->bond = bond;
> > +	xfrm_work->xs = xs;
> > +	xfrm_state_hold(xs);
> > +
> > +	queue_work(bond->wq, &xfrm_work->work);
> 
> Note that nothing waits for this work anywhere and .ndo_uninit runs before
> bond's .priv_destructor which means ipsec_lock will be destroyed and will be
> used afterwards when destroying bond->wq from the destructor if there were
> any queued works.

Do you mean we need to register the work queue in bond_init and cancel
it in bond_work_cancel_all()?

Thanks
Hangbin

