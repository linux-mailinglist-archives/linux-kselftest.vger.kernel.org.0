Return-Path: <linux-kselftest+bounces-45110-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B2CEFC409C3
	for <lists+linux-kselftest@lfdr.de>; Fri, 07 Nov 2025 16:35:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 04E2C1A446B2
	for <lists+linux-kselftest@lfdr.de>; Fri,  7 Nov 2025 15:35:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4DDC532D0D6;
	Fri,  7 Nov 2025 15:35:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CBjXHOYy"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-yw1-f176.google.com (mail-yw1-f176.google.com [209.85.128.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5EE80328B56
	for <linux-kselftest@vger.kernel.org>; Fri,  7 Nov 2025 15:35:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762529715; cv=none; b=VBqzUADFHukH+82ldeSisWi769UVl1ngFIeuNqAyAEVMQbVMlJ61BLHUiSzdeVbvDasmxAJEEm9WushVP9EbK5VkaV+WvWVkD9hVgUU/POwZHKOMQn/7HmmvsQBHPrzGHd0TPSURrPy98fHy4wsR1zvuTMjc1XRTEJ+SWh2DORM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762529715; c=relaxed/simple;
	bh=7m90U4fRlmTtbaduAz/n40bucosBtxg2Nlzb525AIWg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BcP7hDnMhVNRT0yhYJ1Oro2FGtwxQ2SB+ghA9cu2UZSnge9ryuNS016WSupaZdiiB5y2gmf+iWKPRPk6tdL9wFL95No613FqQVWCtPBqeYtdCz5LDzF1aDdjCtkiJEYZK5trrtwkNK+4NClRxf5VmtrKwGeOZdxy8gT6Nk1ertM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CBjXHOYy; arc=none smtp.client-ip=209.85.128.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f176.google.com with SMTP id 00721157ae682-786a822e73aso10248337b3.3
        for <linux-kselftest@vger.kernel.org>; Fri, 07 Nov 2025 07:35:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762529711; x=1763134511; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Hg5UfzPKclS12jZ/MM0cVARNy4+o8xhJZIOiFJg4L64=;
        b=CBjXHOYykeExWbAdUzaTfxbv+hYeDnJ4OE6LMEsIQ+j1HllMQbTwIrF1ZEDn7jXbaG
         lDM2Uj71u4sDtbD+vGnxUFHY34GPfx3h1iW1JsUxF8CYD3oxAyQxZbZplmBquMOloTwP
         oRPywO8QmaIR6yh3L4Hcuck/OkBnD05U+hfOWzV/GEhqkGUyL0NYgE2trQfhP5MA7DoZ
         LQpahZrpYOlvRREH+zpYiz2WBgdGz4j+YhGxFHwBjcPyqqb7GU/IMiM7XEpmL1F9pPbk
         H1bgVT9cQsFpWEguqlEo19mGxZbreY0161jBsEn/zIuo0yFqfn26o9DZH7p0Aat4utdn
         RyuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762529711; x=1763134511;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Hg5UfzPKclS12jZ/MM0cVARNy4+o8xhJZIOiFJg4L64=;
        b=lXov0tg15uIm8UKJFTDhRkheDzeS3+Pm9BSWY2QynOucckb7F0TAIT4a/FkPXsM6ps
         H45A2K2pUzuOXrfFFQ7mnZVOzRpIcUZUZ9lO90qPnnUHtNlebaKkUnRQAGbmZ7xNFg9/
         KKg//1t/83de++IQlDsaLZ1A5m4bQIKBXeXgp0Q8HNOhiTmzuDh1cxUgFKkwsl62IDr2
         Lfeymdm1UsQX8OgKW37gClx0cFPDldwfzzgqS1/Ire2vsBsYQqsAH8PX3aGUrD64eA5C
         4oVEIoD93YPOeb5TQA+o1lvgGlTeS+wq4yzvHjYUUf9G7AdIZDVzVRj8WK+qApE0z23p
         UijQ==
X-Forwarded-Encrypted: i=1; AJvYcCUUJT8tCOKH8J4vk0xBnyVXD/0+Ip/9sjWxquunOQbDP/BclY7ol30IxaCtEzRZuSgs5nDUVFEZ8imSlXgWSFE=@vger.kernel.org
X-Gm-Message-State: AOJu0YzIC6ty0p2paMhJuHx12VcBE+iie2Gq6jGffEb//nubRwyJrjXs
	0Eo1yAZpNpXI5vXd9s1H2PMXXHLEhR4Qa8l5DxoD/btOHjlUfT8Ur6qsgQuURdqj
X-Gm-Gg: ASbGncuAD6dDfAViloEFTAFC0+f3EGUnXjbLQKjNFNl9f4aRGTEjY/OFFzGGmv66cke
	YEz9bS+nq4Gon+JjftPYLIgoKME2msGooxpHNUxd6BGL+eQpP01fY0XaRCeoiDRHZot4AA5Db6+
	OvOHDmWDvmT7jv25kIplPcOUhTdC6jmCm3SktIhg1+snd8b3igwmr6D5SwOhoDCql2iaOShp9Js
	MHnjJADjeaiVde/yyNCipwO8xp+E1lK4dDakQ3jZjt1cCZaxJMFDFfEepbHdbuMGys0o9YT6EMG
	mTfjy1bHrbeXwYPDYOOaEIyfBszqLFIdjwylPByj0ox0CyPojOfJwcmsW/TpE6ARK1zYkU8W//4
	kVCn7jvXg6oGK4RDAg77QIEs6jIY4/54ikR1+T+lbsvyv+aSXVTDWU6CyMB2Hf96F7Vn+zRGgiH
	oI8rW1+rVzZVOYTv7x9XTZ1QSNIcEK+OAL1uLQ
X-Google-Smtp-Source: AGHT+IFwUXomSgFrXOP5T+Zd2zXzyVOrxyGJXDnXPE08lhO8nln1/YwLRBm5iwzEweMUqR/HaaHj6g==
X-Received: by 2002:a05:690c:360e:b0:786:a984:c064 with SMTP id 00721157ae682-787c53f0603mr27190947b3.35.1762529711161;
        Fri, 07 Nov 2025 07:35:11 -0800 (PST)
Received: from devvm11784.nha0.facebook.com ([2a03:2880:25ff:70::])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-787cb4db618sm4770327b3.32.2025.11.07.07.35.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Nov 2025 07:35:10 -0800 (PST)
Date: Fri, 7 Nov 2025 07:35:09 -0800
From: Bobby Eshleman <bobbyeshleman@gmail.com>
To: Simon Horman <horms@kernel.org>
Cc: Stefano Garzarella <sgarzare@redhat.com>, Shuah Khan <shuah@kernel.org>,
	virtualization@lists.linux.dev, netdev@vger.kernel.org,
	linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
	Bobby Eshleman <bobbyeshleman@meta.com>
Subject: Re: [PATCH net-next v3 04/11] selftests/vsock: avoid multi-VM
 pidfile collisions with QEMU
Message-ID: <aQ4RrcB0tzMWch1S@devvm11784.nha0.facebook.com>
References: <20251106-vsock-selftests-fixes-and-improvements-v3-0-519372e8a07b@meta.com>
 <20251106-vsock-selftests-fixes-and-improvements-v3-4-519372e8a07b@meta.com>
 <aQ4LaUi9wTnEN8KA@horms.kernel.org>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aQ4LaUi9wTnEN8KA@horms.kernel.org>

On Fri, Nov 07, 2025 at 03:08:25PM +0000, Simon Horman wrote:
> On Thu, Nov 06, 2025 at 04:49:48PM -0800, Bobby Eshleman wrote:
> 
> ...
> 
> > @@ -90,15 +85,19 @@ vm_ssh() {
> >  }
> >  
> >  cleanup() {
> > -	if [[ -s "${QEMU_PIDFILE}" ]]; then
> > -		pkill -SIGTERM -F "${QEMU_PIDFILE}" > /dev/null 2>&1
> > -	fi
> > +	local pidfile
> >  
> > -	# If failure occurred during or before qemu start up, then we need
> > -	# to clean this up ourselves.
> > -	if [[ -e "${QEMU_PIDFILE}" ]]; then
> > -		rm "${QEMU_PIDFILE}"
> > -	fi
> > +	for pidfile in "${PIDFILES[@]}"; do
> > +		if [[ -s "${pidfile}" ]]; then
> > +			pkill -SIGTERM -F "${pidfile}" > /dev/null 2>&1
> > +		fi
> > +
> > +		# If failure occurred during or before qemu start up, then we need
> > +		# to clean this up ourselves.
> > +		if [[ -e "${pidfile}" ]]; then
> > +			rm "${pidfile}"
> > +		fi
> > +	done
> >  }
> 
> Hi Bobby,
> 
> This is completely untested, but it looks to me
> like cleanup() could be implemented more succinctly like this.
> 
> cleanup() {
> 	terminate_pidfiles "${PIDFILES[@]}"
> }
> 

Oh right! I reverted the deletion and completely forgot about
terminate_pidfiles().

> >  
> >  check_args() {
> > @@ -188,10 +187,35 @@ handle_build() {
> >  	popd &>/dev/null
> >  }
> >  
> > +create_pidfile() {
> > +	local pidfile
> > +
> > +	pidfile=$(mktemp "${PIDFILE_TEMPLATE}")
> > +	PIDFILES+=("${pidfile}")
> > +
> > +	echo "${pidfile}"
> > +}
> > +
> > +terminate_pidfiles() {
> > +	local pidfile
> > +
> > +	for pidfile in "$@"; do
> > +		if [[ -s "${pidfile}" ]]; then
> > +			pkill -SIGTERM -F "${pidfile}" > /dev/null 2>&1
> > +		fi
> > +
> > +		if [[ -e "${pidfile}" ]]; then
> > +			rm -f "${pidfile}"
> > +		fi
> > +	done
> 
> I think it would be useful to remove $pidfile from $PIDFILES.
> This might be easier to implement if PIDFILES was an associative array.
> 

Using an associative makes sense, this way we can trim the set.

> > +}
> > +
> 
> ...
> 
> > @@ -498,7 +529,8 @@ handle_build
> >  echo "1..${#ARGS[@]}"
> >  
> >  log_host "Booting up VM"
> > -vm_start
> > +pidfile="$(create_pidfile)"
> > +vm_start "${pidfile}"
> >  vm_wait_for_ssh
> >  log_host "VM booted up"
> >  
> 
> > @@ -522,6 +554,8 @@ for arg in "${ARGS[@]}"; do
> >  	cnt_total=$(( cnt_total + 1 ))
> >  done
> >  
> > +terminate_pidfiles "${pidfile}"
> 
> I am assuming that there will be more calls to terminate_pidfiles
> in subsequent patch-sets.
> 
> Else I think terminate_pidfiles can be removed
> and instead we can rely on cleanup().
> 

Indeed, later patches will use terminate_pidfiles() in between spin up /
shut down of multiple VMs.


Thanks again, will incorporate your feedback in the next!

Best,
Bobby

