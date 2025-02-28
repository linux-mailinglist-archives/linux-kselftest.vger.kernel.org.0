Return-Path: <linux-kselftest+bounces-27822-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C948EA48E7E
	for <lists+linux-kselftest@lfdr.de>; Fri, 28 Feb 2025 03:20:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 76A49188DC17
	for <lists+linux-kselftest@lfdr.de>; Fri, 28 Feb 2025 02:20:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6685612CD8B;
	Fri, 28 Feb 2025 02:20:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BdvYdf9h"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8ED21A28D;
	Fri, 28 Feb 2025 02:20:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740709239; cv=none; b=JwJ4NVqdwVk6yzxgiO6N6mmaSzdQn95ytfUQBX/nFZ+8+Zb+YXbuFcfEICnegPG88jZyxt07/9MlkV5w+MqffSwfjpVec90ike0aUpRPhXaJSNkyp5YnntTSEMBhHtKzFvLCsawcHYjIwdTQe6xRc5BMxnPnKDDbD2+CicUaD0E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740709239; c=relaxed/simple;
	bh=MMKcWHwZx7iURlsUP1nn3PlScKsO8Oa0L4bgXyt0hBY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pOHKyhGGZ4FlvbhWkEzMQOoGf4BwRBlFo7/YkHyS/qr3jUIbi4jWUFF8ISEWMNVKdY9VtCXR5tOraM2x0eCH04L/+fuRFBIFYnpljgb3Kc7QjIPITQNzF43vvlq6heOTdLE3nKCRlKl1lNulBgylzdWEipnWIloOja5nLXK/WO8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BdvYdf9h; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-2235908a30aso29308105ad.3;
        Thu, 27 Feb 2025 18:20:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740709237; x=1741314037; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=VVNsWFrJHeRxRhz/gzLM7w+xa3MgrQGmsj/P5TJoERQ=;
        b=BdvYdf9hoZcKZnzARssC97dBkHM7TCtIpONSPlGDadmhscqaU82wr5T4fzdUNSbzTl
         JdBOadduZhB1lWrivrQ9byvL1nUem2vhbua58gMNbiG3OfaiTYyzpaxvOw86ttLMDkMg
         DGB9ViRRfD9SNzmwrFbkR+KmwFpTcO3tMP4cYgCEaa32+b0vX1uX47UPdEwv7qLQo1SK
         K5bs3MQ20gTbtWVyKKa6b/uCb64gDvNvIpd4DSa7e44aNaYeWVwK84XmbPY6gIr/eBlZ
         LybSX92GU7qHCdf7LHm3IvLN9eKdOFe8EB1XzkMaG7agrr0wBu8XYF5Reg5YSCR3R/0O
         gZ6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740709237; x=1741314037;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VVNsWFrJHeRxRhz/gzLM7w+xa3MgrQGmsj/P5TJoERQ=;
        b=owKwgle7vXamNEHqRKPSgI0rA4owo2KJqzNZVW9YpszrbWShQ0yi7JP58qUean+2R3
         d/Ynj/R2C3cvN8ZnaERzIZ6ZiL3hO3GdYfmOtMcsgWJFIM2o6wzmoKH/LNnO0wubTDcd
         ePjAx8gjv7r4R4hJVsXvoyE/v1xMHX2131NedPM29o8a8HTqDaJJ6wyYHFeY0QxmG2XN
         ZZPyNZNBNFPWXt7SssddHqAgIkEOEMV9fPN32r5ez85dvSinl5EXawg+J5DGgu+RMCSD
         ksZai2biTtcMM6QMH1qZG76CHNKSw35zo8Q0SV5jwS+jnTP3p7X95wh4cYsXbbXxhsCP
         UBRw==
X-Forwarded-Encrypted: i=1; AJvYcCV/bxFOoyYdKrNACaLoE0mhXOczP0oQZ36M3uHfgJr7fg89K+mJqDUf1yBBhs/MLYAjQvKAWjkbFrq5mzk=@vger.kernel.org, AJvYcCV0rbbkkTbNggNQymIYd2E/jvfze3ZS1fu0NdDhJovt/L5LovnKTo6/jB5mUiT9qAn3aUYgZJCp5ScVp9TLA+RE@vger.kernel.org
X-Gm-Message-State: AOJu0YzlV99g2ih84CGA4MSmdbDKh26APTZtkpZ8OX5QqtcQcyJW4BY7
	OKw4cdToQTn0gG2lomiPL0BubDFeWjTzfDm45PdwEEQWAuvJ+xp0
X-Gm-Gg: ASbGncvV0dxGr9ptvmNu4/xN+AanvJtv297h0j+eE2Q4DXn6+2JLCy6TOOl17+rApgH
	xFSig/siOgTNGh8tQXUbSXqMfNrwXQJBNRZNPV+Y4GW/qK8eQN63iJmSLK10PXDECG9rrhEwIHS
	BCzzLntLKvfA5gscFNLf0aCRLfq0+yPjnUoZT/NaEqYHYHiFUkxJBfpprYDs+06x6HPswBzNRUv
	NBVbcySKVi82ZtA9IZBQpHuUDQOJaUBdoX9GTKWCuI2u2ooEpg2soFEfj6BS754Mh3FpCNjmmMZ
	tjpImADxjR8/EjotK133WTv0UcIKHf4=
X-Google-Smtp-Source: AGHT+IGH5qLMLnJ5TgL2j+AZlrAkU/jpqugN+zfj0S+c5Uu0OuUDf8kwcWGH+NHThOulkfqZlfKE6A==
X-Received: by 2002:a05:6a00:cce:b0:732:1bad:e245 with SMTP id d2e1a72fcca58-734ac34dc5emr2742636b3a.7.1740709236845;
        Thu, 27 Feb 2025 18:20:36 -0800 (PST)
Received: from fedora ([43.228.180.230])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-734a0024df7sm2559417b3a.109.2025.02.27.18.20.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Feb 2025 18:20:32 -0800 (PST)
Date: Fri, 28 Feb 2025 02:20:26 +0000
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
Subject: Re: [PATCHv3 net 1/3] bonding: move IPsec deletion to
 bond_ipsec_free_sa
Message-ID: <Z8EdatcTr9weRfHr@fedora>
References: <20250227083717.4307-1-liuhangbin@gmail.com>
 <20250227083717.4307-2-liuhangbin@gmail.com>
 <446e8ef4-7ac0-43ad-99ff-29c21a2ee117@blackwall.org>
 <13cb4b16-51b0-4042-8435-6dac72586e55@blackwall.org>
 <Z8Bm9i9St0zzDhRZ@fedora>
 <f88b234a-37ec-46a4-b920-35f598ab6c38@blackwall.org>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f88b234a-37ec-46a4-b920-35f598ab6c38@blackwall.org>

On Thu, Feb 27, 2025 at 03:31:01PM +0200, Nikolay Aleksandrov wrote:
> >> One more thing - note I'm not an xfrm expert by far but it seems to me here you have
> >> to also call  xdo_dev_state_free() with the old active slave dev otherwise that will
> >> never get called with the original real_dev after the switch to a new
> >> active slave (or more accurately it might if the GC runs between the switching
> >> but it is a race), care must be taken wrt sequence of events because the XFRM
> > 
> > Can we just call xs->xso.real_dev->xfrmdev_ops->xdo_dev_state_free(xs)
> > no matter xs->xso.real_dev == real_dev or not? I'm afraid calling
> > xdo_dev_state_free() every where may make us lot more easily.
> > 
> 
> You'd have to check all drivers that implement the callback to answer that and even then
> I'd stick to the canonical way of how it's done in xfrm and make the bond just passthrough.
> Any other games become dangerous and new code will have to be carefully reviewed every
> time, calling another device's free_sa when it wasn't added before doesn't sound good.
> 
> >> GC may be running in parallel which probably means that in bond_ipsec_free_sa()
> >> you'll have to take the mutex before calling xdo_dev_state_free() and check
> >> if the entry is still linked in the bond's ipsec list before calling the free_sa
> >> callback, if it isn't then del_sa_all got to it before the GC and there's nothing
> >> to do if it also called the dev's free_sa callback. The check for real_dev doesn't
> >> seem enough to protect against this race.
> > 
> > I agree that we need to take the mutex before calling xdo_dev_state_free()
> > in bond_ipsec_free_sa(). Do you think if this is enough? I'm a bit lot here.
> > 
> > Thanks
> > Hangbin
> 
> Well, the race is between the xfrm GC and del_sa_all, in bond's free_sa if you
> walk the list under the mutex before calling real_dev's free callback and
> don't find the current element that's being freed in free_sa then it was
> cleaned up by del_sa_all, otherwise del_sa_all is waiting to walk that
> list and clean the entries. I think it should be fine as long as free_sa
> was called once with the proper device.

OK, so the free will be called either in del_sa_all() or free_sa().
Something like this?

 static void bond_ipsec_del_sa_all(struct bonding *bond)
@@ -620,6 +614,16 @@ static void bond_ipsec_del_sa_all(struct bonding *bond)
 		if (!ipsec->xs->xso.real_dev)
 			continue;
 
+		if (ipsec->xs->km.state == XFRM_STATE_DEAD) {
+			/* already dead no need to delete again */
+			if (real_dev->xfrmdev_ops->xdo_dev_state_free)
+				real_dev->xfrmdev_ops->xdo_dev_state_free(ipsec->xs);
+			list_del(&ipsec->list);
+			kfree(ipsec);
+			continue;
+		}
+
 		if (!real_dev->xfrmdev_ops ||
 		    !real_dev->xfrmdev_ops->xdo_dev_state_delete ||
 		    netif_is_bond_master(real_dev)) {
 
@@ -659,11 +664,22 @@ static void bond_ipsec_free_sa(struct xfrm_state *xs)
 	if (!xs->xso.real_dev)
 		goto out;
 
-	WARN_ON(xs->xso.real_dev != real_dev);
+	mutex_lock(&bond->ipsec_lock);
+	list_for_each_entry(ipsec, &bond->ipsec_list, list) {
+		if (ipsec->xs == xs) {
+			if (real_dev && xs->xso.real_dev == real_dev &&

                           ^^ looks we don't need this xs->xso.real_dev == real_dev
			   checking if there is no race, do we? Or just keep
			   the WARN_ON() in case of any race.

+			    real_dev->xfrmdev_ops &&
+			    real_dev->xfrmdev_ops->xdo_dev_state_free)
+				real_dev->xfrmdev_ops->xdo_dev_state_free(xs);
+			list_del(&ipsec->list);
+			kfree(ipsec);
+			break;
+		}
+	}
+	mutex_unlock(&bond->ipsec_lock);
 
-	if (real_dev && real_dev->xfrmdev_ops &&
-	    real_dev->xfrmdev_ops->xdo_dev_state_free)
-		real_dev->xfrmdev_ops->xdo_dev_state_free(xs);
 out:
 	netdev_put(real_dev, &tracker);
 }
-- 
2.39.5 (Apple Git-154)


Thanks
Hangbin

