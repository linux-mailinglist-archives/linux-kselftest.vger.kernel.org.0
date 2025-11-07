Return-Path: <linux-kselftest+bounces-45090-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 6BD04C40169
	for <lists+linux-kselftest@lfdr.de>; Fri, 07 Nov 2025 14:23:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 3D3B54EDF95
	for <lists+linux-kselftest@lfdr.de>; Fri,  7 Nov 2025 13:23:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DDC702D8788;
	Fri,  7 Nov 2025 13:23:34 +0000 (UTC)
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-ed1-f51.google.com (mail-ed1-f51.google.com [209.85.208.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3AC9D2D7DDA
	for <linux-kselftest@vger.kernel.org>; Fri,  7 Nov 2025 13:23:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762521814; cv=none; b=rxyZdaWdSC5eJjaelOfAwjq64kr5PaBMr5wAJaq7mXYTjQZ3ZyZ1DD45at2vM7LuCVd8SkyrH6QPZxfqcuF5i1vXt5fMaxkS12NlUd7+0VyHDMxxUjZgKoHCT/C2a9uHt6u5c2WFa/j1GWP1eJyf2gMKySnXIYu0LPB10KLn6gM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762521814; c=relaxed/simple;
	bh=DGJ9+559FlV3UgQikrelkoCmYfFxJQL1ZC4qTlqeSWA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VleBJGmD15yJmlZJ2OZrD6JjdwdSvJJJfq8aFTwA+KjLIbLcmaPv47BQeIkPcFsrLa82avnFtkcmUpyg76IlviAA/ZtYVX5TCfkmi6TkaL37/n+5IzrhAYuVLfyq5mQzW6Urvc+XFIP8Ed5jiP5mofN/6GKs3MCPZhIvhOzRP7k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.208.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f51.google.com with SMTP id 4fb4d7f45d1cf-640860f97b5so1288529a12.2
        for <linux-kselftest@vger.kernel.org>; Fri, 07 Nov 2025 05:23:30 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762521809; x=1763126609;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hdV1jfrMy32tfsxFe1Wpkv2OHa2IiVAYkwnI7QBJXd0=;
        b=rP/3HXz+8qi8VNg3/pGUr5cFBLdDn9MRuumGzlOFqHK85quDRkZbfkpi8+T62dyVMM
         CnFKVJWbiIDQ1Gc62S8TIjTTxiYz0eRouE5RKFGkSt+5xRO5SyU6cqi/8r+EupHLTdVZ
         5bXrde+2pEuEPXokqRzgCBIiJIAIY+yp3ctFul06iZVeUG1Vf3cGiSihTIO2W6DFsw7d
         62miXs9/jEYTspcpZkLZt21sRwHEWweBoI13cTclvL3zXBT1rPSIRBr3MFZxR9qzbdU0
         P03tzgVsD82pQJ4w95avWML27cH9cWb4hkBVu9autb57Wiow/ZOguBiyV/tK+3Vc14sj
         2xiQ==
X-Forwarded-Encrypted: i=1; AJvYcCX1dc4atABiteS23cnp6yKFNVQWuLABlKRJp9vwvM/mHap3K+6nuBNHpoJwu+04sAV+PPUR2mcc+I7UhK/HS2A=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy/eJp0FCKXpAgmFoFddEnoV3tKm+sW9T8U/ELBhReaSIAYFXPx
	xKpRWQh4qSbyWrQJDl/yApkslcNGqFlPEw6g5YlvWtV0kCj4lVtfVfm54CWXgw==
X-Gm-Gg: ASbGncv68v0NWv8wU/5GBnezRw4P6Isbzl7V5DexQHHTPRkPE5wMA+fhZcmNgT62fSA
	J4Xrndnw3jSKfDbhOfLwyB41Fx4qXN3QBbcoJWCx/tvudYC+8buTNijJhuqHhWr3nMBcr1gCvrz
	sg7fWbAj8gtDSMYgS3aI5Q7AwnIsIZpjNLoeGuuk78szvFdyBkhsV91jvMpVOK6FR4Jt8A1NYo4
	Nzt8dr6SGtFJDl0xPaFbwJVKnQpHAdfRwXdb8Mz3rpdltbfry11J4j+ExJyTVzFa6R9hpVGoXVn
	YpX/ssKTfuaQRyFb0ZpS/o8Boi1IZxPgAUF99qqxJqJDf/NtpUjWHQYmkolRs61Q5bgOD4UbrHt
	U58XEekd2vibDDcCVCnOEJT76n2ZCMPhEHvo9sZU7HdCWXG6Elv7rZ8J5K5WRARXjBA==
X-Google-Smtp-Source: AGHT+IEpoL7HaRFc7e20vexFAi3ULjF7HkITUJu5y1US5JRjD7tBhB6YkZ/emLsN0v1+Ob7GVBczyg==
X-Received: by 2002:a17:907:1b0a:b0:b70:7cd8:9098 with SMTP id a640c23a62f3a-b72c0ed00dcmr322377266b.61.1762521809164;
        Fri, 07 Nov 2025 05:23:29 -0800 (PST)
Received: from gmail.com ([2a03:2880:30ff:1::])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b72bf7231dcsm242895566b.31.2025.11.07.05.23.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Nov 2025 05:23:28 -0800 (PST)
Date: Fri, 7 Nov 2025 05:23:26 -0800
From: Breno Leitao <leitao@debian.org>
To: Gustavo Luiz Duarte <gustavold@gmail.com>
Cc: Andre Carvalho <asantostc@gmail.com>, Simon Horman <horms@kernel.org>, 
	Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, Shuah Khan <shuah@kernel.org>, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org
Subject: Re: [PATCH net-next 2/4] netconsole: Split userdata and sysdata
Message-ID: <jejsptfg7cqmbcm467tb72gg3mwsqge6iz4qy4wy5ifev2sgim@hukyfgsr74xj>
References: <20251105-netconsole_dynamic_extradata-v1-0-142890bf4936@meta.com>
 <20251105-netconsole_dynamic_extradata-v1-2-142890bf4936@meta.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251105-netconsole_dynamic_extradata-v1-2-142890bf4936@meta.com>

On Wed, Nov 05, 2025 at 09:06:44AM -0800, Gustavo Luiz Duarte wrote:
> Separate userdata and sysdata into distinct buffers to enable independent
> management. Previously, both were stored in a single extradata_complete
> buffer with a fixed size that accommodated both types of data.
> 
> This separation allows:
> - userdata to grow dynamically (in subsequent patch)
> - sysdata to remain in a small static buffer
> - removal of complex entry counting logic that tracked both types together
> 
> The split also simplifies the code by eliminating the need to check total
> entry count across both userdata and sysdata when enabling features,
> which allows to drop holding su_mutex on sysdata_*_enabled_store().
> 
> No functional change in this patch, just structural preparation for
> dynamic userdata allocation.
> 
> Signed-off-by: Gustavo Luiz Duarte <gustavold@gmail.com>
> ---
>  drivers/net/netconsole.c | 204 +++++++++++++++++++----------------------------
>  1 file changed, 84 insertions(+), 120 deletions(-)
> 
> diff --git a/drivers/net/netconsole.c b/drivers/net/netconsole.c
> index 0a8ba7c4bc9d..e780c884db83 100644
> --- a/drivers/net/netconsole.c
> +++ b/drivers/net/netconsole.c
> @@ -50,7 +50,8 @@ MODULE_LICENSE("GPL");
>  /* The number 3 comes from userdata entry format characters (' ', '=', '\n') */
>  #define MAX_EXTRADATA_NAME_LEN		(MAX_EXTRADATA_ENTRY_LEN - \
>  					MAX_EXTRADATA_VALUE_LEN - 3)
> -#define MAX_EXTRADATA_ITEMS		16
> +#define MAX_USERDATA_ITEMS		16

Do we still need to have MAX_USERDATA_ITEMS cap with your new approach?

> +#define MAX_SYSDATA_ITEMS		4

Can we have this one inside enum sysdata_feature?

Something as:

  enum sysdata_feature {
      SYSDATA_CPU_NR = BIT(0),
      SYSDATA_TASKNAME = BIT(1),
      SYSDATA_RELEASE = BIT(2),
      SYSDATA_MSGID = BIT(3),
      MAX_SYSDATA_ITEMS = 4  /* Sentinel: highest bit position */
  };

>  #define MAX_PRINT_CHUNK			1000
>  
>  static char config[MAX_PARAM_LENGTH];
> @@ -122,8 +123,9 @@ enum sysdata_feature {
>   * @list:	Links this target into the target_list.
>   * @group:	Links us into the configfs subsystem hierarchy.
>   * @userdata_group:	Links to the userdata configfs hierarchy
> - * @extradata_complete:	Cached, formatted string of append
> - * @userdata_length:	String length of usedata in extradata_complete.
> + * @userdata:		Cached, formatted string of append
> + * @userdata_length:	String length of userdata.
> + * @sysdata:		Cached, formatted string of append
>   * @sysdata_fields:	Sysdata features enabled.
>   * @msgcounter:	Message sent counter.
>   * @stats:	Packet send stats for the target. Used for debugging.
> @@ -152,8 +154,10 @@ struct netconsole_target {
>  #ifdef	CONFIG_NETCONSOLE_DYNAMIC
>  	struct config_group	group;
>  	struct config_group	userdata_group;
> -	char extradata_complete[MAX_EXTRADATA_ENTRY_LEN * MAX_EXTRADATA_ITEMS];
> +	char			userdata[MAX_EXTRADATA_ENTRY_LEN * MAX_USERDATA_ITEMS];
>  	size_t			userdata_length;
> +	char			sysdata[MAX_EXTRADATA_ENTRY_LEN * MAX_SYSDATA_ITEMS];
> +
>  	/* bit-wise with sysdata_feature bits */
>  	u32			sysdata_fields;
>  	/* protected by target_list_lock */
> @@ -802,28 +806,14 @@ static ssize_t remote_ip_store(struct config_item *item, const char *buf,
>  	return ret;
>  }
>  
> -/* Count number of entries we have in extradata.
> - * This is important because the extradata_complete only supports
> - * MAX_EXTRADATA_ITEMS entries. Before enabling any new {user,sys}data
> - * feature, number of entries needs to checked for available space.
> +/* Count number of entries we have in userdata.
> + * This is important because userdata only supports MAX_USERDATA_ITEMS
> + * entries. Before enabling any new userdata feature, number of entries needs
> + * to checked for available space.
>   */
> -static size_t count_extradata_entries(struct netconsole_target *nt)
> +static size_t count_userdata_entries(struct netconsole_target *nt)
>  {
> -	size_t entries;
> -
> -	/* Userdata entries */
> -	entries = list_count_nodes(&nt->userdata_group.cg_children);
> -	/* Plus sysdata entries */
> -	if (nt->sysdata_fields & SYSDATA_CPU_NR)
> -		entries += 1;
> -	if (nt->sysdata_fields & SYSDATA_TASKNAME)
> -		entries += 1;
> -	if (nt->sysdata_fields & SYSDATA_RELEASE)
> -		entries += 1;
> -	if (nt->sysdata_fields & SYSDATA_MSGID)
> -		entries += 1;
> -
> -	return entries;
> +	return list_count_nodes(&nt->userdata_group.cg_children);
>  }
>  
>  static ssize_t remote_mac_store(struct config_item *item, const char *buf,
> @@ -894,13 +884,13 @@ static void update_userdata(struct netconsole_target *nt)
>  
>  	/* Clear the current string in case the last userdatum was deleted */
>  	nt->userdata_length = 0;
> -	nt->extradata_complete[0] = 0;
> +	nt->userdata[0] = 0;
>  
>  	list_for_each(entry, &nt->userdata_group.cg_children) {
>  		struct userdatum *udm_item;
>  		struct config_item *item;
>  
> -		if (child_count >= MAX_EXTRADATA_ITEMS) {
> +		if (child_count >= MAX_USERDATA_ITEMS) {
>  			spin_unlock_irqrestore(&target_list_lock, flags);
>  			WARN_ON_ONCE(1);
>  			return;
> @@ -914,11 +904,11 @@ static void update_userdata(struct netconsole_target *nt)
>  		if (strnlen(udm_item->value, MAX_EXTRADATA_VALUE_LEN) == 0)
>  			continue;
>  
> -		/* This doesn't overflow extradata_complete since it will write
> -		 * one entry length (1/MAX_EXTRADATA_ITEMS long), entry count is
> +		/* This doesn't overflow userdata since it will write
> +		 * one entry length (1/MAX_USERDATA_ITEMS long), entry count is
>  		 * checked to not exceed MAX items with child_count above
>  		 */
> -		nt->userdata_length += scnprintf(&nt->extradata_complete[nt->userdata_length],
> +		nt->userdata_length += scnprintf(&nt->userdata[nt->userdata_length],
>  						 MAX_EXTRADATA_ENTRY_LEN, " %s=%s\n",
>  						 item->ci_name, udm_item->value);
>  	}
> @@ -960,7 +950,7 @@ static void disable_sysdata_feature(struct netconsole_target *nt,
>  				    enum sysdata_feature feature)
>  {
>  	nt->sysdata_fields &= ~feature;
> -	nt->extradata_complete[nt->userdata_length] = 0;
> +	nt->sysdata[0] = 0;
>  }
>  
>  static ssize_t sysdata_msgid_enabled_store(struct config_item *item,
> @@ -979,12 +969,6 @@ static ssize_t sysdata_msgid_enabled_store(struct config_item *item,
>  	if (msgid_enabled == curr)
>  		goto unlock_ok;
>  
> -	if (msgid_enabled &&
> -	    count_extradata_entries(nt) >= MAX_EXTRADATA_ITEMS) {
> -		ret = -ENOSPC;
> -		goto unlock;
> -	}
> -
>  	if (msgid_enabled)
>  		nt->sysdata_fields |= SYSDATA_MSGID;
>  	else
> @@ -992,7 +976,6 @@ static ssize_t sysdata_msgid_enabled_store(struct config_item *item,
>  
>  unlock_ok:
>  	ret = strnlen(buf, count);
> -unlock:
>  	mutex_unlock(&dynamic_netconsole_mutex);
>  	return ret;
>  }
> @@ -1013,12 +996,6 @@ static ssize_t sysdata_release_enabled_store(struct config_item *item,
>  	if (release_enabled == curr)
>  		goto unlock_ok;
>  
> -	if (release_enabled &&
> -	    count_extradata_entries(nt) >= MAX_EXTRADATA_ITEMS) {
> -		ret = -ENOSPC;
> -		goto unlock;
> -	}
> -
>  	if (release_enabled)
>  		nt->sysdata_fields |= SYSDATA_RELEASE;
>  	else
> @@ -1026,7 +1003,6 @@ static ssize_t sysdata_release_enabled_store(struct config_item *item,
>  
>  unlock_ok:
>  	ret = strnlen(buf, count);
> -unlock:
>  	mutex_unlock(&dynamic_netconsole_mutex);
>  	return ret;
>  }
> @@ -1047,12 +1023,6 @@ static ssize_t sysdata_taskname_enabled_store(struct config_item *item,
>  	if (taskname_enabled == curr)
>  		goto unlock_ok;
>  
> -	if (taskname_enabled &&
> -	    count_extradata_entries(nt) >= MAX_EXTRADATA_ITEMS) {
> -		ret = -ENOSPC;
> -		goto unlock;
> -	}
> -
>  	if (taskname_enabled)
>  		nt->sysdata_fields |= SYSDATA_TASKNAME;
>  	else
> @@ -1060,7 +1030,6 @@ static ssize_t sysdata_taskname_enabled_store(struct config_item *item,
>  
>  unlock_ok:
>  	ret = strnlen(buf, count);
> -unlock:
>  	mutex_unlock(&dynamic_netconsole_mutex);
>  	return ret;
>  }
> @@ -1083,27 +1052,16 @@ static ssize_t sysdata_cpu_nr_enabled_store(struct config_item *item,
>  		/* no change requested */
>  		goto unlock_ok;
>  
> -	if (cpu_nr_enabled &&
> -	    count_extradata_entries(nt) >= MAX_EXTRADATA_ITEMS) {
> -		/* user wants the new feature, but there is no space in the
> -		 * buffer.
> -		 */
> -		ret = -ENOSPC;
> -		goto unlock;
> -	}
> -
>  	if (cpu_nr_enabled)
>  		nt->sysdata_fields |= SYSDATA_CPU_NR;
>  	else
> -		/* This is special because extradata_complete might have
> -		 * remaining data from previous sysdata, and it needs to be
> -		 * cleaned.
> +		/* This is special because sysdata might have remaining data
> +		 * from previous sysdata, and it needs to be cleaned.
>  		 */
>  		disable_sysdata_feature(nt, SYSDATA_CPU_NR);
>  
>  unlock_ok:
>  	ret = strnlen(buf, count);
> -unlock:
>  	mutex_unlock(&dynamic_netconsole_mutex);
>  	return ret;
>  }
> @@ -1146,7 +1104,7 @@ static struct config_item *userdatum_make_item(struct config_group *group,
>  
>  	ud = to_userdata(&group->cg_item);
>  	nt = userdata_to_target(ud);
> -	if (count_extradata_entries(nt) >= MAX_EXTRADATA_ITEMS)
> +	if (count_userdata_entries(nt) >= MAX_USERDATA_ITEMS)
>  		return ERR_PTR(-ENOSPC);
>  
>  	udm = kzalloc(sizeof(*udm), GFP_KERNEL);
> @@ -1353,22 +1311,21 @@ static void populate_configfs_item(struct netconsole_target *nt,
>  
>  static int sysdata_append_cpu_nr(struct netconsole_target *nt, int offset)
>  {
> -	/* Append cpu=%d at extradata_complete after userdata str */
> -	return scnprintf(&nt->extradata_complete[offset],
> +	return scnprintf(&nt->sysdata[offset],
>  			 MAX_EXTRADATA_ENTRY_LEN, " cpu=%u\n",

This is confusing. It is writing to sysdata but checking extradata entry len.

>  static int sysdata_append_taskname(struct netconsole_target *nt, int offset)
>  {
> -	return scnprintf(&nt->extradata_complete[offset],
> +	return scnprintf(&nt->sysdata[offset],
>  			 MAX_EXTRADATA_ENTRY_LEN, " taskname=%s\n",

Same as above.

>  }
>  
>  static int sysdata_append_release(struct netconsole_target *nt, int offset)
>  {
> -	return scnprintf(&nt->extradata_complete[offset],
> +	return scnprintf(&nt->sysdata[offset],
>  			 MAX_EXTRADATA_ENTRY_LEN, " release=%s\n",
>  			 init_utsname()->release);
>  }
> @@ -1376,46 +1333,36 @@ static int sysdata_append_release(struct netconsole_target *nt, int offset)
>  static int sysdata_append_msgid(struct netconsole_target *nt, int offset)
>  {
>  	wrapping_assign_add(nt->msgcounter, 1);
> -	return scnprintf(&nt->extradata_complete[offset],
> +	return scnprintf(&nt->sysdata[offset],
>  			 MAX_EXTRADATA_ENTRY_LEN, " msgid=%u\n",
>  			 nt->msgcounter);
>  }
>  
>  /*
> - * prepare_extradata - append sysdata at extradata_complete in runtime
> + * prepare_sysdata - append sysdata in runtime
>   * @nt: target to send message to
>   */
> -static int prepare_extradata(struct netconsole_target *nt)
> +static int prepare_sysdata(struct netconsole_target *nt)
>  {
> -	int extradata_len;
> -
> -	/* userdata was appended when configfs write helper was called
> -	 * by update_userdata().
> -	 */
> -	extradata_len = nt->userdata_length;
> +	int sysdata_len = 0;
>  
>  	if (!nt->sysdata_fields)
>  		goto out;
>  
>  	if (nt->sysdata_fields & SYSDATA_CPU_NR)
> -		extradata_len += sysdata_append_cpu_nr(nt, extradata_len);
> +		sysdata_len += sysdata_append_cpu_nr(nt, sysdata_len);
>  	if (nt->sysdata_fields & SYSDATA_TASKNAME)
> -		extradata_len += sysdata_append_taskname(nt, extradata_len);
> +		sysdata_len += sysdata_append_taskname(nt, sysdata_len);
>  	if (nt->sysdata_fields & SYSDATA_RELEASE)
> -		extradata_len += sysdata_append_release(nt, extradata_len);
> +		sysdata_len += sysdata_append_release(nt, sysdata_len);
>  	if (nt->sysdata_fields & SYSDATA_MSGID)
> -		extradata_len += sysdata_append_msgid(nt, extradata_len);
> +		sysdata_len += sysdata_append_msgid(nt, sysdata_len);
>  
> -	WARN_ON_ONCE(extradata_len >
> -		     MAX_EXTRADATA_ENTRY_LEN * MAX_EXTRADATA_ITEMS);
> +	WARN_ON_ONCE(sysdata_len >
> +		     MAX_EXTRADATA_ENTRY_LEN * MAX_SYSDATA_ITEMS);
>  
>  out:
> -	return extradata_len;
> -}
> -#else /* CONFIG_NETCONSOLE_DYNAMIC not set */
> -static int prepare_extradata(struct netconsole_target *nt)
> -{
> -	return 0;
> +	return sysdata_len;
>  }
>  #endif	/* CONFIG_NETCONSOLE_DYNAMIC */
>  
> @@ -1517,13 +1464,8 @@ static void send_msg_no_fragmentation(struct netconsole_target *nt,
>  				      int msg_len,
>  				      int release_len)
>  {
> -	const char *extradata = NULL;
>  	const char *release;
>  
> -#ifdef CONFIG_NETCONSOLE_DYNAMIC
> -	extradata = nt->extradata_complete;
> -#endif
> -
>  	if (release_len) {
>  		release = init_utsname()->release;
>  
> @@ -1533,11 +1475,11 @@ static void send_msg_no_fragmentation(struct netconsole_target *nt,
>  		memcpy(nt->buf, msg, msg_len);
>  	}
>  
> -	if (extradata)
> -		msg_len += scnprintf(&nt->buf[msg_len],
> -				     MAX_PRINT_CHUNK - msg_len,
> -				     "%s", extradata);
> -
> +#ifdef CONFIG_NETCONSOLE_DYNAMIC
> +	msg_len += scnprintf(&nt->buf[msg_len],
> +			     MAX_PRINT_CHUNK - msg_len,
> +			     "%s%s", nt->userdata, nt->sysdata);
> +#endif

I am not sure I like this ifdef in here. Can you if userdata or sysdata are
valid, and then scnprintf() instead of using ifdef?

>  				 const char *msgbody, int header_len,
> -				 int msgbody_len, int extradata_len)
> +				 int msgbody_len, int sysdata_len)
>  {
> -	const char *extradata = NULL;
> +	const char *userdata = NULL;
> +	const char *sysdata = NULL;
>  	int body_len, offset = 0;
> -	int extradata_offset = 0;
> +	int userdata_offset = 0;
>  	int msgbody_offset = 0;
> +	int sysdata_offset = 0;
> +	int userdata_len = 0;
>  
>  #ifdef CONFIG_NETCONSOLE_DYNAMIC
> -	extradata = nt->extradata_complete;
> +	userdata = nt->userdata;
> +	sysdata = nt->sysdata;
> +	userdata_len = nt->userdata_length;
>  #endif
> -	if (WARN_ON_ONCE(!extradata && extradata_len != 0))
> +	if (WARN_ON_ONCE(!userdata && userdata_len != 0))
> +		return;
> +
> +	if (WARN_ON_ONCE(!sysdata && sysdata_len != 0))
>  		return;
>  
>  	/* body_len represents the number of bytes that will be sent. This is
>  	 * bigger than MAX_PRINT_CHUNK, thus, it will be split in multiple
>  	 * packets
>  	 */
> -	body_len = msgbody_len + extradata_len;
> +	body_len = msgbody_len + userdata_len + sysdata_len;
>  
>  	/* In each iteration of the while loop below, we send a packet
>  	 * containing the header and a portion of the body. The body is
> -	 * composed of two parts: msgbody and extradata. We keep track of how
> -	 * many bytes have been sent so far using the offset variable, which
> -	 * ranges from 0 to the total length of the body.
> +	 * composed of three parts: msgbody, userdata and sysdata.
> +	 * We keep track of how many bytes have been sent from each part using
> +	 * the *_offset variables.
> +	 * We keep track of how many bytes have been sent overall using the
> +	 * offset variable, which ranges from 0 to the total length of the
> +	 * body.
>  	 */
>  	while (offset < body_len) {
>  		int this_header = header_len;
> @@ -1594,12 +1547,20 @@ static void send_fragmented_body(struct netconsole_target *nt,
>  		msgbody_offset += this_chunk;
>  		this_offset += this_chunk;
>  
> -		/* after msgbody, append extradata */
> -		this_chunk = min(extradata_len - extradata_offset,
> +		/* after msgbody, append userdata */
> +		this_chunk = min(userdata_len - userdata_offset,

Please assign this "userdata_len - userdata_offset" to a variable and give it a
name, so, it help us to reason about the code. 

>  				 MAX_PRINT_CHUNK - this_header - this_offset);
>  		memcpy(nt->buf + this_header + this_offset,
> -		       extradata + extradata_offset, this_chunk);
> -		extradata_offset += this_chunk;
> +		       userdata + userdata_offset, this_chunk);
> +		userdata_offset += this_chunk;
> +		this_offset += this_chunk;
> +
> +		/* after userdata, append sysdata */
> +		this_chunk = min(sysdata_len - sysdata_offset,
> +				 MAX_PRINT_CHUNK - this_header - this_offset);
> +		memcpy(nt->buf + this_header + this_offset,
> +		       sysdata + sysdata_offset, this_chunk);

s/this_header/this_header_offset?

Now that you are touching this code, please review these variable to keep them named correct.

Maybe adding _ptr for pointer, and _offset for offsets and _len for lenghts?

Thank you for your work reasong about all of this!
--breno

