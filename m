Return-Path: <linux-kselftest+bounces-22303-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D69959D2C1A
	for <lists+linux-kselftest@lfdr.de>; Tue, 19 Nov 2024 18:07:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 96266284B5B
	for <lists+linux-kselftest@lfdr.de>; Tue, 19 Nov 2024 17:07:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C1571D0B91;
	Tue, 19 Nov 2024 17:07:52 +0000 (UTC)
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-ed1-f52.google.com (mail-ed1-f52.google.com [209.85.208.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6448714A639;
	Tue, 19 Nov 2024 17:07:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732036072; cv=none; b=llS9Pz2Qxa5Qi7kzfLj42cfhokELK1g4Cqmgqbv7czpxGvKnIyfY+/AwwDxVtoHOiJCMHWL3rceKc1SMTys3+oBs6OEQoFXMR4ZEMasriVdsD9qRYtzdGYLNEvN2avWvXXgH3lDaAGwwBnuwgJMT9vv0aTd9QPJJWlqTjLvH9Ic=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732036072; c=relaxed/simple;
	bh=/eMefCL6Nmke9tyGIDIOTzluMSRQ6dN1d/wEhqhLEHo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=g9xL6eVv42ZTtbZJciTT9DkNJWKRoNhnO8dARyTneztRy1raefHEz43ImP6Req89f/83BqBGtTEw/LAo4JOMaTat/b4Xlsh5iL2q6hBz9Ijsur0PbVljkM/a/YnpWy5FjS97rayAYnj3WiPP0QReUVoTjSNQJUOzUfeWYyue6KA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.208.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f52.google.com with SMTP id 4fb4d7f45d1cf-5ced377447bso8170302a12.1;
        Tue, 19 Nov 2024 09:07:50 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732036069; x=1732640869;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CO3DmDyk2Ke5HC3Rep1JIDjgJE+KxbTNcrUJlPMJpRU=;
        b=OcBvouMUqjDnpm3May41R50Cq4do95jQnvlgig776CTUT7l1s9TB4mAl4VMD3DyT8F
         i+ZHsnV8929lZGkQG3k3lvXD3IvPyO3qeCbZUJNee+Zl/9/MpKypKY2s7oVvdKLzFswh
         pf9o8f4y1oCnmd44yq6U/eCLQzpj83FxwpOrAju59ya6JQ6iJqVU7rD4UPsqCCmENXJo
         VwpQWvACeXW3NNfKYGcAN/yQvCmFZmflHNPjdbZHLsl+UbNewm+IK4X5rIr3vv03I7Tw
         TJn0Av1tD1nnmYmzzIwhA44vaMOClNsvxV+VNkHdZ+lEVz/YYJJ00n20yjofJna35zji
         DA8g==
X-Forwarded-Encrypted: i=1; AJvYcCV5bZgL1lt/wU1l1MNlGuBlGWaJWwkkJWqHRbgOH5aKsY+zeAZud1K9UBcHJXnJOM/IzJ9gNM0+@vger.kernel.org, AJvYcCVi6jHOlDB7mOGNP0cOlh5wr6AygwGfIyG5E+lB+/tcyksR9ITrvddf6M8cXH0MhriQMUV4Z6UJGAY=@vger.kernel.org, AJvYcCWBETCUFHJzHM7Tuo20qEEhsqRIl01JvB4lVBVG2z5ib91EpmPiu0k6xmbGfonTT/SVSS5T40SH/vWx3cvs@vger.kernel.org, AJvYcCWef5tEbOY8FY2ZGx/yD3Wo+f7Iv3XkrPTrjppNTahQWQVvZBMzMmh5XUYcksu9ldywocP1x+3CAQpx4/VjIfQW@vger.kernel.org
X-Gm-Message-State: AOJu0YyQx/AyuJGpb4Q8dN1hTgcgUu0E+AcvZkkuG0grWG7IrcVzE0aD
	6dy4ZPaSjc40CaGJETYuAQdIQOCcY5o7q0HUpLNChWp4cW0iRKa/
X-Google-Smtp-Source: AGHT+IGrdjBEX3xCb7oVm3Do1Lo3MG9PQDXDyZjN11EqcOgR1O7iu5WnoajOMZ/Jh2txK9eYMNPVWQ==
X-Received: by 2002:a17:907:3f8d:b0:a9e:b471:8006 with SMTP id a640c23a62f3a-aa483508ae4mr1527245266b.43.1732036068486;
        Tue, 19 Nov 2024 09:07:48 -0800 (PST)
Received: from gmail.com (fwdproxy-lla-007.fbsv.net. [2a03:2880:30ff:7::face:b00c])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-aa20df52adasm668235966b.81.2024.11.19.09.07.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Nov 2024 09:07:48 -0800 (PST)
Date: Tue, 19 Nov 2024 09:07:45 -0800
From: Breno Leitao <leitao@debian.org>
To: Jakub Kicinski <kuba@kernel.org>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>, Jonathan Corbet <corbet@lwn.net>,
	Shuah Khan <shuah@kernel.org>, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
	linux-kselftest@vger.kernel.org, max@kutsevol.com,
	thepacketgeek@gmail.com, vlad.wing@gmail.com,
	davej@codemonkey.org.uk
Subject: Re: [PATCH net-next 2/4] netconsole: Add option to auto-populate CPU
 number in userdata
Message-ID: <20241119-talented-strong-grouse-1f02fd@leitao>
References: <20241113-netcon_cpu-v1-0-d187bf7c0321@debian.org>
 <20241113-netcon_cpu-v1-2-d187bf7c0321@debian.org>
 <20241118183336.34e42b01@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241118183336.34e42b01@kernel.org>

Hello Jakub,

On Mon, Nov 18, 2024 at 06:33:36PM -0800, Jakub Kicinski wrote:
> Sorry for the late review, I think this will miss v6.13 :(

That is fine, there is no rush for this change.

> On Wed, 13 Nov 2024 07:10:53 -0800 Breno Leitao wrote:
> >  /**
> >   * struct netconsole_target - Represents a configured netconsole target.
> >   * @list:	Links this target into the target_list.
> > @@ -97,6 +105,7 @@ static struct console netconsole_ext;
> >   * @userdata_group:	Links to the userdata configfs hierarchy
> >   * @userdata_complete:	Cached, formatted string of append
> >   * @userdata_length:	String length of userdata_complete
> > + * @userdata_auto:	Kernel auto-populated bitwise fields in userdata.
> >   * @enabled:	On / off knob to enable / disable target.
> >   *		Visible from userspace (read-write).
> >   *		We maintain a strict 1:1 correspondence between this and
> > @@ -123,6 +132,7 @@ struct netconsole_target {
> >  	struct config_group	userdata_group;
> >  	char userdata_complete[MAX_USERDATA_ENTRY_LENGTH * MAX_USERDATA_ITEMS];
> >  	size_t			userdata_length;
> > +	enum userdata_auto	userdata_auto;
> 
> If you want to set multiple bits here type should probably be unsigned
> long. Otherwise the enum will contain combination of its values, which
> are in themselves not valid enum values ... if that makes sense.

Yes, it does make sense. I had the feeling that something was off as
well, but I was unclear if using something different than `enum
userdata_auto` would be better. I will change to `unsigned long`
> 
> >  #endif
> >  	bool			enabled;
> >  	bool			extended;
> 
> > +	/* Check if CPU NR should be populated, and append it to the user
> > +	 * dictionary.
> > +	 */
> > +	if (child_count < MAX_USERDATA_ITEMS && nt->userdata_auto & AUTO_CPU_NR)
> > +		scnprintf(&nt->userdata_complete[complete_idx],
> > +			  MAX_USERDATA_ENTRY_LENGTH, " cpu=%u\n",
> > +			  raw_smp_processor_id());
> 
> I guess it may be tricky for backward compat, but shouldn't we return
> an error rather than silently skip?

yes, this should be easy to do, in fact. Probably return -E2BIG to
userspace when trying to update the entry. I thought about something as
the following patch, and piggy-back into it.

   Author: Breno Leitao <leitao@debian.org>
   Date:   Tue Nov 19 04:32:56 2024 -0800
   
       netconsole: Enforce userdata entry limit
   
       Currently, attempting to add more than MAX_USERDATA_ITEMS to the userdata
       dictionary silently fails. This patch modifies the code to return -E2BIG
       when the number of elements exceeds the preallocated limit, providing clear
       feedback to userspace about the failure.
   
       Suggested-by: Jakub Kicinski <kuba@kernel.org>
       Signed-off-by: Breno Leitao <leitao@debian.org>
   
   diff --git a/drivers/net/netconsole.c b/drivers/net/netconsole.c
   index 4ea44a2f48f7b..41cff8c8e8f42 100644
   --- a/drivers/net/netconsole.c
   +++ b/drivers/net/netconsole.c
   @@ -692,10 +692,11 @@ static ssize_t userdatum_value_show(struct config_item *item, char *buf)
    	return sysfs_emit(buf, "%s\n", &(to_userdatum(item)->value[0]));
    }
   
   -static void update_userdata(struct netconsole_target *nt)
   +static int update_userdata(struct netconsole_target *nt)
    {
    	int complete_idx = 0, child_count = 0;
    	struct list_head *entry;
   +	int ret = 0;
   
    	/* Clear the current string in case the last userdatum was deleted */
    	nt->userdata_length = 0;
   @@ -705,8 +706,10 @@ static void update_userdata(struct netconsole_target *nt)
    		struct userdatum *udm_item;
    		struct config_item *item;
   
   -		if (child_count >= MAX_USERDATA_ITEMS)
   +		if (child_count >= MAX_USERDATA_ITEMS) {
   +			ret = -E2BIG;
    			break;
   +		}
    		child_count++;
   
    		item = container_of(entry, struct config_item, ci_entry);
   @@ -726,6 +729,7 @@ static void update_userdata(struct netconsole_target *nt)
    	}
    	nt->userdata_length = strnlen(nt->userdata_complete,
    				      sizeof(nt->userdata_complete));
   +	return ret;
    }
   
    static ssize_t userdatum_value_store(struct config_item *item, const char *buf,
   @@ -748,8 +752,9 @@ static ssize_t userdatum_value_store(struct config_item *item, const char *buf,
   
    	ud = to_userdata(item->ci_parent);
    	nt = userdata_to_target(ud);
   -	update_userdata(nt);
   -	ret = count;
   +	ret = update_userdata(nt);
   +	if (!ret)
   +		ret = count;
    out_unlock:
    	mutex_unlock(&dynamic_netconsole_mutex);
    	return ret;
   

> 
> >  	nt->userdata_length = strnlen(nt->userdata_complete,
> >  				      sizeof(nt->userdata_complete));
> >  }
> > @@ -757,7 +788,36 @@ static ssize_t userdatum_value_store(struct config_item *item, const char *buf,
> >  	return ret;
> >  }
> >  
> > +static ssize_t populate_cpu_nr_store(struct config_item *item, const char *buf,
> > +				     size_t count)
> > +{
> > +	struct netconsole_target *nt = to_target(item->ci_parent);
> > +	bool cpu_nr_enabled;
> > +	ssize_t ret;
> > +
> > +	if (!nt)
> > +		return -EINVAL;
> 
> Can this happen? Only if function gets called with a NULL @item
> which would be pretty nutty.

Probably not. It is just me being chicken here. I will remove it for the
next version.

Thanks for the review,
--breno

