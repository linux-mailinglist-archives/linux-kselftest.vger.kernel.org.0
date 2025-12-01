Return-Path: <linux-kselftest+bounces-46798-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id C63A7C97129
	for <lists+linux-kselftest@lfdr.de>; Mon, 01 Dec 2025 12:38:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 983044E232C
	for <lists+linux-kselftest@lfdr.de>; Mon,  1 Dec 2025 11:35:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A4DF26ED51;
	Mon,  1 Dec 2025 11:35:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=debian.org header.i=@debian.org header.b="ZFaVxMI0"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from stravinsky.debian.org (stravinsky.debian.org [82.195.75.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61D9A26C3B6;
	Mon,  1 Dec 2025 11:35:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=82.195.75.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764588920; cv=none; b=OMwJelWmcXy4h6zqxuhIgBpeN0RP04qeyW2MvGJAjRneIMDcIAeVZrrWQyOS7MzIoD/msAfpPO6U0GA6nOpAE/jWT2i0f/GDiB3Vs3/P2u/gtjByT7llroiObBd3jC1/y/JD0GsinHCU52DIQ3P6CjW0WxEWkYYInhV7OpjGkvU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764588920; c=relaxed/simple;
	bh=KI1Ijegz9/wIzZEx/nIZUvhNGkt/+DNgbyJIFeKjfcI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SahFpqhlL0aUZ9ROEyApJaAqWLzhJ9egW2JTfgvD2RZSB7Ju9mk41U7VmMtq6dCN2xSeYqYr/ouOfgMZEGSfOOrbqZLLEsK9FqLIJSwmPD3G/JY5343oSaJ1faQPfYdxsbizk76zGd5/VXpglOrEgUQDdVhSX+AZe3rueJIWNDA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=none smtp.mailfrom=debian.org; dkim=pass (2048-bit key) header.d=debian.org header.i=@debian.org header.b=ZFaVxMI0; arc=none smtp.client-ip=82.195.75.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=debian.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=debian.org;
	s=smtpauto.stravinsky; h=X-Debian-User:In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=B1n2wwbLh7ZtXzvdamUIb2IVlWJUblxFZrBlZl2SoDM=; b=ZFaVxMI0pFRf8mv+d5G43bUYwe
	ha1OY8mAx17gsIWLOLnQMBpnmqjkfdRjdc97Tzd7OcGxiOAW8kIt0uQ/NQwqpiLgfGEcjoWY8U6ma
	fCa/zja8ficck7mP9n2VR69kK8k+xm2Yy4YQgteMNCM5znodSX1hNrX7735iNoGj0p3Ce+grFLFho
	HRDFq3/rJ9bYXqS7KMnGSnEQ1cr7fOn4ewvLcq2GElZVVgKjBXu6qYRQhtCE3aKX/4xHwMObkjagY
	76IiwJvIV/QMtgXNDb4hozSzV5D9jq9kPTqDI8o0EJav0Z1RzC1pE/8JdHel1kxvFDSPS9IMnxwaZ
	E8xctk+Q==;
Received: from authenticated user
	by stravinsky.debian.org with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.94.2)
	(envelope-from <leitao@debian.org>)
	id 1vQ2BS-000bos-M9; Mon, 01 Dec 2025 11:35:10 +0000
Date: Mon, 1 Dec 2025 03:35:04 -0800
From: Breno Leitao <leitao@debian.org>
To: Andre Carvalho <asantostc@gmail.com>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Shuah Khan <shuah@kernel.org>, 
	Simon Horman <horms@kernel.org>, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-kselftest@vger.kernel.org
Subject: Re: [PATCH net-next v8 4/5] netconsole: resume previously
 deactivated target
Message-ID: <65vs7a63onl37a7q7vjxo7wgmgkdcixkittcrirdje2e6qmkkj@syujqrygyvcd>
References: <20251128-netcons-retrigger-v8-0-0bccbf4c6385@gmail.com>
 <20251128-netcons-retrigger-v8-4-0bccbf4c6385@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251128-netcons-retrigger-v8-4-0bccbf4c6385@gmail.com>
X-Debian-User: leitao

Hello Andre,

On Fri, Nov 28, 2025 at 10:08:03PM +0000, Andre Carvalho wrote:
> @@ -242,6 +249,75 @@ static void populate_configfs_item(struct netconsole_target *nt,
>  }
>  #endif	/* CONFIG_NETCONSOLE_DYNAMIC */
>  
> +/* Check if the target was bound by mac address. */
> +static bool bound_by_mac(struct netconsole_target *nt)
> +{
> +	return is_valid_ether_addr(nt->np.dev_mac);
> +}
> +
> +/* Attempts to resume logging to a deactivated target. */
> +static void resume_target(struct netconsole_target *nt)
> +{
> +	int ret;
> +
> +	/* check if target is still deactivated as it may have been disabled
> +	 * while resume was being scheduled.
> +	 */
This only happens if this is a dynamic target and someone is toggling
the device (or even removing it, which would cause a crash I _think_).

Given you are completely lockless here, so, there is a chance you hit
a TOCTOU, also.

I think you want to have dynamic_netconsole_mutex held during the
operation of process_resume_target().

  * mutex_lock(&dynamic_netconsole_mutex);
  * remove from the list
  * resume
  * re-add to the list
  * mutex_unlock(&dynamic_netconsole_mutex);
  

netconsole design has two locks:
  * target lock list, which protects devices getting disabled by netdev
    notifications
  * dynamic_netconsole_mutex, which protects anyone disabling and
    removing the target from configfs

> +	if (nt->state != STATE_DEACTIVATED)
> +		return;
> +
> +	if (bound_by_mac(nt))
> +		/* ensure netpoll_setup will retrieve device by mac */
> +		memset(&nt->np.dev_name, 0, IFNAMSIZ);

This is a clean-up step that was missing whent the target is getting
down, and htis is just a work around that doesn't belong in here.

Please move it to netconsole_process_cleanups_core(), in a separate
patch.

Something as: 

	list_for_each_entry_safe(nt, tmp, &target_cleanup_list, list)
		do_netpoll_cleanup(&nt->np);
		if (bound_by_mac(nt))
			memset(&nt->np.dev_name, 0, IFNAMSIZ);
			

Ideally this should belong to do_netpoll_cleanup(), but let's keep it in
netconsole_process_cleanups_core() for three reasons:


1) Bounding by mac is a netconsole concept
2) do_netpoll_cleanup() is only used by netconsole, and I plan to move
   it back to netconsole. Some PoC in [1]
3) bound_by_mac() should be in netconsole and we do not want to export
   it.

[1]:
https://lore.kernel.org/all/20250902-netpoll_untangle_v3-v1-3-51a03d6411be@debian.org/

> +
> +	ret = netpoll_setup(&nt->np);
> +	if (ret) {
> +		/* netpoll fails setup once, do not try again. */
> +		nt->state = STATE_DISABLED;
> +		return;
> +	}
> +
> +	nt->state = STATE_ENABLED;
> +	pr_info("network logging resumed on interface %s\n", nt->np.dev_name);
> +}
> +
> +/* Checks if a deactivated target matches a device. */
> +static bool deactivated_target_match(struct netconsole_target *nt,
> +				     struct net_device *ndev)
> +{
> +	if (nt->state != STATE_DEACTIVATED)
> +		return false;
> +
> +	if (bound_by_mac(nt))
> +		return !memcmp(nt->np.dev_mac, ndev->dev_addr, ETH_ALEN);
> +	return !strncmp(nt->np.dev_name, ndev->name, IFNAMSIZ);
> +}
> +
> +/* Process work scheduled for target resume. */
> +static void process_resume_target(struct work_struct *work)
> +{
> +	struct netconsole_target *nt =
> +		container_of(work, struct netconsole_target, resume_wq);
> +	unsigned long flags;
> +

mutex_lock(&dynamic_netconsole_mutex);
As discussed above

> +	/* resume_target is IRQ unsafe, remove target from
> +	 * target_list in order to resume it with IRQ enabled.
> +	 */
> +	spin_lock_irqsave(&target_list_lock, flags);
> +	list_del_init(&nt->list);
> +	spin_unlock_irqrestore(&target_list_lock, flags);
> +
> +	resume_target(nt);
> +
> +	/* At this point the target is either enabled or disabled and
> +	 * was cleaned up before getting deactivated. Either way, add it
> +	 * back to target list.
> +	 */
> +	spin_lock_irqsave(&target_list_lock, flags);
> +	list_add(&nt->list, &target_list);
> +	spin_unlock_irqrestore(&target_list_lock, flags);

mutex_unlock(&dynamic_netconsole_mutex);

> +}
> +
>  /* Allocate and initialize with defaults.
>   * Note that these targets get their config_item fields zeroed-out.
>   */
> @@ -264,6 +340,7 @@ static struct netconsole_target *alloc_and_init(void)
>  	nt->np.remote_port = 6666;
>  	eth_broadcast_addr(nt->np.remote_mac);
>  	nt->state = STATE_DISABLED;
> +	INIT_WORK(&nt->resume_wq, process_resume_target);

It needs to be initialized earlier before the kzalloc, otherwise we
might hit a similar problem to the one fixed by e5235eb6cfe0  ("net:
netpoll: initialize work queue before error checks")

The code path would be:
  * alloc_param_target()
	  * alloc_and_init()
		  * kzalloc() fails and return NULL.
		  * resume_wq() is still not initialized
  fail:
	* free_param_target()
		* cancel_work_sync(&nt->resume_wq); and resume_wq is not
		  initialized

Thanks for the patch,
--breno

--
pw-bot: cr

