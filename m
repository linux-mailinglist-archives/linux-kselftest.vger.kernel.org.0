Return-Path: <linux-kselftest+bounces-27582-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A6350A45A8E
	for <lists+linux-kselftest@lfdr.de>; Wed, 26 Feb 2025 10:48:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B880C3AC846
	for <lists+linux-kselftest@lfdr.de>; Wed, 26 Feb 2025 09:48:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0CA61226CFB;
	Wed, 26 Feb 2025 09:48:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="K18et+uI"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pj1-f46.google.com (mail-pj1-f46.google.com [209.85.216.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 789122AE9A;
	Wed, 26 Feb 2025 09:48:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740563327; cv=none; b=oYEhKhVTnf7D34yidv3vK8kECqoJcaSIK+/98qrRKcwNyFhqZ2xn1u1hxeUEhzHY4xwbsqWyGRnCb94UZxOL9MkdGK/ohVuA40R91JcvGxYAkjRrcGZAoq8oZdtpTBn2kdxMQEygMwWVKxMotOXzegBCMljEXk6EDRMnJHb5qdM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740563327; c=relaxed/simple;
	bh=YHnWMxsDd4NI3G57XP3K3uhiH2OsB3c9BFnE3iwI+R4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Cc/UpfxmJ8Uu/hA+8eMoEEXoimXmcM23UGq7zpNhpwYnraeLysZUk5jwRekdU8OD1NDE15qfKggmAy4Ah9wb2SZahl5dFC20wN9qQP1zT5zKGYxRdqc+hRAnBnpBc9tAhAZykFiHjh4/rzlIorFzqhTnvwl1x52Q7Wum3P49PiY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=K18et+uI; arc=none smtp.client-ip=209.85.216.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f46.google.com with SMTP id 98e67ed59e1d1-2f9b9c0088fso1113801a91.0;
        Wed, 26 Feb 2025 01:48:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740563325; x=1741168125; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=PLcQO0F1bTUCUpJSJ+y0elRMBmjObmFBfYrryjf1JY8=;
        b=K18et+uICN9DCMmdeyVcVVaBkpMS7rHSOBkvHCwsO0JhW3pw4lUzvDhC7QAw6jAsYi
         VxQtDocSn2MhToJ7+YFRvWT9Iycfjb+3PcWoVTa4AMbvv6zO4gVyMQMGYW5MeCBKIi9j
         tFgnS1a0M+hI0y3qdkapYpSygRwwlPV3UIwbCrz60CnWbqM1S4nTl2iJB9U7etz3a6oH
         XGplcSQrt778yAjm+lArVMHr7wPCdkLjgjYpXyDDrFY6pwoHdBUcBsPgrKF9+9QDzyDo
         7lVcQnm9fZR/sTOR+EZCuVqCfSmI2bhW2AwngCAr+Nk9C3uVXMlgg4ROPcpxaswVAfi9
         XZzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740563325; x=1741168125;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PLcQO0F1bTUCUpJSJ+y0elRMBmjObmFBfYrryjf1JY8=;
        b=I/NwTdoeVAPQ4DgmmXHmPvNRrqJzD9CL1aahfHuURUx8Z8XJULOcEg/Kwy4juNtTqO
         HSFnxmvJQIGspAah3F3AZzPDZiMiqE8La+DEiiVuzln3ITlf1TWOR6Pk5hj8ew5on9uI
         Q2RraH2B8QlEL/7kAC3o331NesDVJ/6+7oxg/TvWkaksiGZGE6HFZC2wFjdVdX9G2gGX
         wRImfyHBeP76LYIDCXt2DWIdrOJzha46lhRnlwQxCFKEAHrBSXEeoz1hVFyT+N6pw3Zx
         J7/4z/WcsvtQ5f6y9oCDncRfH+xlsH7qQi2UZ8ABVSXiqKIIUQB2zH8ttwTFNiUqGHaH
         BRXw==
X-Forwarded-Encrypted: i=1; AJvYcCWZgWG4wGhhUxJkRv5IIs8/pgG4fAogAyD7pHstfnFWMEUQasEhnQoJG6Eh4Tdlimn64vCNocUhyQLs56kO+LtD@vger.kernel.org, AJvYcCWdRJ2ln8xuP2wNVuoe6tGGAPKEtN8mcKl63ecCQ9zXT/rZ2t614g4wa/wf4bHdFJkhQB5xSjkOLorBQ2c=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx1+HU5CBM5hptsRsqCqPcQZWU9xl87tfogXO1cpHuPmO4lPYHB
	T2nTx92f8WMZ8OdTQAVN1yJnmHU6kzi7PYn+qp34y8Ccy+ShRAlq
X-Gm-Gg: ASbGnctU5B8oE7w4xXGy6do1fijdi8RtnOv5QqIhP3MbX4Mw9PA5puJYUMdadCPu0I7
	OlCedlKVDbO79shitnH/bITmcdVogjGxa3r/Fx5Pe+4H0Supv49JVMP+CJOIqQWLNLcgOqN2fpy
	BZwbKfFAa4Y+Vm7286KOeAeviqQCyqhv1hisKk58orysV4kyjNheLDq2ptXOVT/7w2pF9LXBWWr
	pk7UaKB7iiLW0BIrLGJM/dho6eNIIAfrutx/IvAGRrrRaq7oGtykjivd+uIOBlUMuQXlrlqtjHU
	VlT6hTRjOb3/8t6DV6DpcPsD2za3z/Y=
X-Google-Smtp-Source: AGHT+IFlo4foFMWPg/DN45x8tUVnr6ByaRax2qGODemzI9Qn99M3p6q6BuIgPgp4/81TS1aJavK+Nw==
X-Received: by 2002:a17:90b:1f8c:b0:2fa:9c9:20a3 with SMTP id 98e67ed59e1d1-2fce763d546mr36534184a91.0.1740563324499;
        Wed, 26 Feb 2025 01:48:44 -0800 (PST)
Received: from fedora ([43.228.180.230])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2fe6cf92bcfsm1844153a91.0.2025.02.26.01.48.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Feb 2025 01:48:43 -0800 (PST)
Date: Wed, 26 Feb 2025 09:48:35 +0000
From: Hangbin Liu <liuhangbin@gmail.com>
To: Cosmin Ratiu <cratiu@nvidia.com>
Cc: "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"andrew+netdev@lunn.ch" <andrew+netdev@lunn.ch>,
	"jarod@redhat.com" <jarod@redhat.com>,
	"razor@blackwall.org" <razor@blackwall.org>,
	"davem@davemloft.net" <davem@davemloft.net>,
	Tariq Toukan <tariqt@nvidia.com>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"shuah@kernel.org" <shuah@kernel.org>,
	"steffen.klassert@secunet.com" <steffen.klassert@secunet.com>,
	"jv@jvosburgh.net" <jv@jvosburgh.net>,
	"pabeni@redhat.com" <pabeni@redhat.com>,
	"horms@kernel.org" <horms@kernel.org>,
	"edumazet@google.com" <edumazet@google.com>,
	"kuba@kernel.org" <kuba@kernel.org>,
	"linux-kselftest@vger.kernel.org" <linux-kselftest@vger.kernel.org>,
	Jianbo Liu <jianbol@nvidia.com>
Subject: Re: [PATCHv2 net 1/3] bonding: move mutex lock to a work queue for
 XFRM GC tasks
Message-ID: <Z77jc8AB3D2xWczl@fedora>
References: <20250225094049.20142-1-liuhangbin@gmail.com>
 <20250225094049.20142-2-liuhangbin@gmail.com>
 <d298da7bc638c323e6d492b2dec7f1b9ea1e1350.camel@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d298da7bc638c323e6d492b2dec7f1b9ea1e1350.camel@nvidia.com>

Hi Cosmin,
On Tue, Feb 25, 2025 at 02:00:05PM +0000, Cosmin Ratiu wrote:
> This got me to stare at the code again. What if we move the removal of
> the xs from bond->ipsec from bond_ipsec_del_sa to bond_ipsec_free_sa?
> bond_ipsec_free_sa, unlike bond_ipsec_del_sa, is not called with x-
> >lock held. It is called from the xfrm gc task or directly via
> xfrm_state_put_sync and therefore wouldn't suffer from the locking
> issue.
> 
> The tricky part is to make sure that inactive bond->ipsec entries
> (after bond_ipsec_del_sa calls) do not cause issues if there's a
> migration (bond_ipsec_del_sa_all is called) happening before
> bond_ipsec_free_sa. Perhaps filtering by x->km.state != XFRM_STATE_DEAD
> in bond_ipsec_del_sa_all.
> 
> What do you think about this idea?

Thanks a lot for the comments. I also skipped the DEAD xs in add_sa_all.
What about the patch like:

diff --git a/drivers/net/bonding/bond_main.c b/drivers/net/bonding/bond_main.c
index e45bba240cbc..0e4db43a833a 100644
--- a/drivers/net/bonding/bond_main.c
+++ b/drivers/net/bonding/bond_main.c
@@ -537,6 +537,12 @@ static void bond_ipsec_add_sa_all(struct bonding *bond)
 	}
 
 	list_for_each_entry(ipsec, &bond->ipsec_list, list) {
+		/* No need to handle DEAD XFRM, as it has already been
+		 * deleted and will be freed later.
+		 */
+		if (ipsec->xs->km.state == XFRM_STATE_DEAD)
+			continue;
+
 		/* If new state is added before ipsec_lock acquired */
 		if (ipsec->xs->xso.real_dev == real_dev)
 			continue;
@@ -592,15 +598,6 @@ static void bond_ipsec_del_sa(struct xfrm_state *xs)
 	real_dev->xfrmdev_ops->xdo_dev_state_delete(xs);
 out:
 	netdev_put(real_dev, &tracker);
-	mutex_lock(&bond->ipsec_lock);
-	list_for_each_entry(ipsec, &bond->ipsec_list, list) {
-		if (ipsec->xs == xs) {
-			list_del(&ipsec->list);
-			kfree(ipsec);
-			break;
-		}
-	}
-	mutex_unlock(&bond->ipsec_lock);
 }
 
 static void bond_ipsec_del_sa_all(struct bonding *bond)
@@ -617,6 +614,12 @@ static void bond_ipsec_del_sa_all(struct bonding *bond)
 
 	mutex_lock(&bond->ipsec_lock);
 	list_for_each_entry(ipsec, &bond->ipsec_list, list) {
+		/* No need to handle DEAD XFRM, as it has already been
+		 * deleted and will be freed later.
+		 */
+		if (ipsec->xs->km.state == XFRM_STATE_DEAD)
+			continue;
+
 		if (!ipsec->xs->xso.real_dev)
 			continue;
 
@@ -666,6 +669,16 @@ static void bond_ipsec_free_sa(struct xfrm_state *xs)
 		real_dev->xfrmdev_ops->xdo_dev_state_free(xs);
 out:
 	netdev_put(real_dev, &tracker);
+
+	mutex_lock(&bond->ipsec_lock);
+	list_for_each_entry(ipsec, &bond->ipsec_list, list) {
+		if (ipsec->xs == xs) {
+			list_del(&ipsec->list);
+			kfree(ipsec);
+			break;
+		}
+	}
+	mutex_unlock(&bond->ipsec_lock);
 }
 
 /**
-- 
2.46.0


