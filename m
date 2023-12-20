Return-Path: <linux-kselftest+bounces-2259-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A2F8B819FB8
	for <lists+linux-kselftest@lfdr.de>; Wed, 20 Dec 2023 14:20:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 579731F23417
	for <lists+linux-kselftest@lfdr.de>; Wed, 20 Dec 2023 13:20:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2AE1F2576F;
	Wed, 20 Dec 2023 13:20:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="UEQFJGi0"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-ej1-f42.google.com (mail-ej1-f42.google.com [209.85.218.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E1992CCB4
	for <linux-kselftest@vger.kernel.org>; Wed, 20 Dec 2023 13:19:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-ej1-f42.google.com with SMTP id a640c23a62f3a-a2696852965so90506866b.0
        for <linux-kselftest@vger.kernel.org>; Wed, 20 Dec 2023 05:19:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1703078396; x=1703683196; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=z0xUf7XH5kyb5fC0NhpZWzqAoF/01X2YPp9dvLbCEYw=;
        b=UEQFJGi0TClyLcVuf7M3xw5bsLgDM2u2hYQz0Ith9iNI+juhBvqwtuVM1dA9ebJ1Vj
         +Y/EMEXcn2HlhAwShErkUksDFnz3Qqx/T7C4gjd3gf5V99ufVUu9mImoY3rHWUh1IAYQ
         kiI6H9RUykQpgx5GBGyuWN5HE60/EqG5iANFq+A5Tesud8VfYqog8jlMhOWgqNs1I5wv
         r2E0q7WKaU1ajhND3dSUu+UdrLUcAUdamQSAPHm8se1p90U25mp4RArfbqHE/72UE72G
         4R8rZiNZovAuK+FA1y3YQWJ6tZEmdjSnKfwr0DITTKtSUkG/esT+kjQlyvtr01Jan8Sv
         pDiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703078396; x=1703683196;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=z0xUf7XH5kyb5fC0NhpZWzqAoF/01X2YPp9dvLbCEYw=;
        b=Safgmk42XVxap+VJrLhLVoQEapwRukJA/xvxNdk2rjzUNa8q4nbbzXyQgPRBmQbASf
         GqTgkFttNl0F5gC6q71tm7z7b3CvCDZNSbBzdTwHqUgFP3jegDZDkhV1Lv59tKO+o0z7
         C7MRCj2X2dIElYgiiAT5QgNyPLLh81/HVAUMJXf7um+cBfiMogcAa/CLaU53nfm7lj+q
         cOGmInhd2kovdzl+mO2ga9/d8ELBjAG1/pjvsi8i180UU9kWV4mbnipwx8fKSedLlZHy
         H56Zelqe0nUzKiQYoyLAL1bufEiv2zbJQR1IMy8eIh2gILy8Xd71QGkYm4RSi5DoXn5M
         EWcg==
X-Gm-Message-State: AOJu0YxBK0i+ReAnzPnvY+pkT//LV13TGDxJn6RB7HHDre29lBd29Jjr
	kg+dKFlzRBLbYCWNaYpt7aasTH/4irvNK5lOxjfOTlzNgis=
X-Google-Smtp-Source: AGHT+IHgEGfw4Lkwc3xt9Yso9HxmBGguRw9WaOFC7SzR4VLbiujJrS89ssd683nvb8WVaVdBopVBEw==
X-Received: by 2002:a17:906:37c4:b0:a26:99fa:a74a with SMTP id o4-20020a17090637c400b00a2699faa74amr348528ejc.33.1703078396432;
        Wed, 20 Dec 2023 05:19:56 -0800 (PST)
Received: from alley ([176.114.240.50])
        by smtp.gmail.com with ESMTPSA id em4-20020a056402364400b00551d6d51401sm1704796edb.53.2023.12.20.05.19.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Dec 2023 05:19:56 -0800 (PST)
Date: Wed, 20 Dec 2023 14:19:54 +0100
From: Petr Mladek <pmladek@suse.com>
To: Joe Lawrence <joe.lawrence@redhat.com>
Cc: Alexander Gordeev <agordeev@linux.ibm.com>,
	Josh Poimboeuf <jpoimboe@kernel.org>,
	Jiri Kosina <jikos@kernel.org>, Miroslav Benes <mbenes@suse.cz>,
	linux-kselftest@vger.kernel.org, live-patching@vger.kernel.org,
	linux-s390@vger.kernel.org
Subject: Re: selftests/livepatch fails on s390
Message-ID: <ZYLpw5vN0d0BbJSL@alley>
References: <ZYAimyPYhxVA9wKg@li-008a6a4c-3549-11b2-a85c-c5cc2836eea2.ibm.com>
 <cf087c7e-d24d-5cee-eadd-dd1fe26efe39@redhat.com>
 <ZYDLZkXdJ22AXtLW@redhat.com>
 <ZYFmOfFgsOdeikec@li-008a6a4c-3549-11b2-a85c-c5cc2836eea2.ibm.com>
 <8adb8209-d49b-4feb-5ab3-47ca4f3cefbc@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8adb8209-d49b-4feb-5ab3-47ca4f3cefbc@redhat.com>

On Tue 2023-12-19 09:50:18, Joe Lawrence wrote:
> On 12/19/23 04:45, Alexander Gordeev wrote:
> > On Mon, Dec 18, 2023 at 05:44:54PM -0500, Joe Lawrence wrote:
> > 
> >> @@ -280,7 +268,13 @@ function set_pre_patch_ret {
> >>  function start_test {
> >>  	local test="$1"
> >>  
> >> -	save_dmesg
> >> +	# Dump something unique into the dmesg log, then stash the entry
> >> +	# in LAST_DMESG.  The check_result() function will use it to
> >> +	# find new kernel messages since the test started.
> >> +	local timestamp="$(date --rfc-3339=ns)"
> >> +	log "livepatch kselftest timestamp: $timestamp"
> >> +	LAST_DMESG=$(dmesg | grep "livepatch kselftest timestamp: $timestamp")

I like this approach.

> > Not sure if it not paranoid mode, but still..
> > If the 'log' call is guaranteed synced? AKA would 'grep' always catch the line?

I believe that the write is synchronized. The "log" command does:

function log() {
	echo "$1" > /dev/kmsg
}

The message is stored into the log buffer during the write to
/dev/kmsg(). See devkmsg_emit() in devkmsg_write(), where
devkmsg_write() is .write_iter callback in struct file_operations.

const struct file_operations kmsg_fops = {
	.open = devkmsg_open,
	.read = devkmsg_read,
	.write_iter = devkmsg_write,
	.llseek = devkmsg_llseek,
	.poll = devkmsg_poll,
	.release = devkmsg_release,
};

I would explect that the write() callback is called directly when
shell is writing "echo" stdout to /dev/kmsg.

I hope that all this is sychronous. Everything is in memory.
I think that write operations are asynchronous only when
the data are written to a disk or another "slow" medium.

And dmesg reads the data from the ring buffer as well. It is
actually using /dev/kmsg as well by default.

Best Regards,
Petr

