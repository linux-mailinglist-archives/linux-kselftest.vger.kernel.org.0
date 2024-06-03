Return-Path: <linux-kselftest+bounces-11109-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 67CE48D82EE
	for <lists+linux-kselftest@lfdr.de>; Mon,  3 Jun 2024 14:53:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1CE8228B38D
	for <lists+linux-kselftest@lfdr.de>; Mon,  3 Jun 2024 12:53:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5FA0612CD98;
	Mon,  3 Jun 2024 12:53:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="DIxv5Akl"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-lj1-f172.google.com (mail-lj1-f172.google.com [209.85.208.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE92F12CD88
	for <linux-kselftest@vger.kernel.org>; Mon,  3 Jun 2024 12:52:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717419182; cv=none; b=lpQM17yQghnx7pv6oPK4UZAojbwWJ6Lamg88nnbTEqeMAAPzN9EKN0e4JVNs6cXg1bTVTGHeSix4ZUNw2OkZLp7ysfBXDsJe5Eqat4LAplkHeHyKDk5vpNctgZSRxbTEXkJur+KBFrjV7Fo2fmey5Mchq8rFHQtH7OM5MTNkjR8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717419182; c=relaxed/simple;
	bh=pNq1s3DpJNlX0e3eT1st05PC02KAmTuKksptOpchj0Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rtzyTUQG+07g33BKV9bKco+xNqPgtu/rr0BrxlsX02r5/3JxhAFSSB679Fhk3yNFAgYSukY7m/7iPdFOw4I2znYjGsfCMfLwQki/X0dUW3YE/8yuBjcyYN4VA61SzuBbzEUTH2rw8O5vklAgWeDBuP12sLkzi8aYZikwm+ghBKU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=DIxv5Akl; arc=none smtp.client-ip=209.85.208.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-lj1-f172.google.com with SMTP id 38308e7fff4ca-2e95a74d51fso64469941fa.2
        for <linux-kselftest@vger.kernel.org>; Mon, 03 Jun 2024 05:52:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1717419177; x=1718023977; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=L1vdMIjKLbGuERAwMMc+hoHFnU3loELjM3GLOoEq1gI=;
        b=DIxv5AkleP4d8CCcenZvq+9lRtAnNfFmxcY651Qe7/V8ekSYlnNWELc6syxICXonk6
         h2bgBVQ6LRpfH7jV6quATxfM78h3d4RSdSzcvxkYq/UKJ5ZmgtXwNXa5l07QVkUxgWAh
         i/+OE7b4GetTRBKkQ9LlioPcVDmfCxYVT+Hc64ZZl9uMGrKmovRPkPiaHUzpJqjOiVDu
         AhrAwT6cs+UkeYbBdiy9ew3ejWBzffcpWfwCTK3ZFDGdyIj0Q9lTTb6pAhvTxJuBZR4b
         QeWb6JdRQbyF1hbxUBjavoK4xS9agWS5sjbwj8OqYOzQSTRSpLTaoO+2m/QJOPR+zTwB
         caMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717419177; x=1718023977;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=L1vdMIjKLbGuERAwMMc+hoHFnU3loELjM3GLOoEq1gI=;
        b=r23nzB0en7K13VYmVA1TcjQShM1HP3UTy2L5+hPvZtRf/iujjEAxMRQK6u14vBi0GW
         79bJym7bkT9DXcy0qICXcRGzs9VCTLlPpXsNsjBaGtpC9Pwgd6OtgmplVqOMZvybsmDJ
         bhtxi+UE7ZP5uO1XBarav9eg8rv7zbkL6NRv907H1EV/eVDKaz/8Ck7/g+KoT3r2KlI/
         fLxA4zs4UvciE7Hbokk1AJsQEb8YX6zYpyHb2Ke/k9BofyU751Hobk3IZHuLvgeQmBUF
         v5HAxTQf0jgzapLvOvee9ilQ6PjucPG2eOUqo/pxgqEDb5RIcWTiDNIaYj0EwaiottBf
         VA5A==
X-Forwarded-Encrypted: i=1; AJvYcCXQkNBZG+flJ7kHcl1Rb3aOpqv03kCSQ//Wf9OvrqiliqTHd6zUYiBrXnh8h3GNtRLVQ2fxtUWsvcuJfoQ9DolKo7ElVOuGZgbNKU/P5eFB
X-Gm-Message-State: AOJu0YxZdi7W2AMwv79mtuWoWNE3Q9BKL4N1T275S0ur+8EGMq4ern2G
	HJrH4OhKjRB3iIYZW+wEoKm+bsFAoK0Loj/zexJ0PjhY5LKs8PrD4I+HWu8RPhg=
X-Google-Smtp-Source: AGHT+IFexEDdIc9suGe8USwivPE4g3apQQFJLnkcTrlu4EUxJ9iQoDZJj4mPTRlDUrxswZmvnGocOQ==
X-Received: by 2002:a2e:818c:0:b0:2ea:8163:5f4f with SMTP id 38308e7fff4ca-2ea951ddf8emr83938091fa.41.1717419176882;
        Mon, 03 Jun 2024 05:52:56 -0700 (PDT)
Received: from pathway.suse.cz ([176.114.240.50])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-6c35a88cfaasm5213953a12.94.2024.06.03.05.52.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Jun 2024 05:52:56 -0700 (PDT)
Date: Mon, 3 Jun 2024 14:52:45 +0200
From: Petr Mladek <pmladek@suse.com>
To: Marcos Paulo de Souza <mpdesouza@suse.com>
Cc: Joe Lawrence <joe.lawrence@redhat.com>,
	Josh Poimboeuf <jpoimboe@kernel.org>,
	Jiri Kosina <jikos@kernel.org>, Miroslav Benes <mbenes@suse.cz>,
	Shuah Khan <shuah@kernel.org>, live-patching@vger.kernel.org,
	linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] selftests: livepatch: Test atomic replace against
 multiple modules
Message-ID: <Zl28ne_laBawq-KP@pathway.suse.cz>
References: <20240525-lp-atomic-replace-v2-1-142199bb65a1@suse.com>
 <ZloormpDnnc4SDub@redhat.com>
 <92d683bd138a76e6c7100f4984be202dd06c9424.camel@suse.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <92d683bd138a76e6c7100f4984be202dd06c9424.camel@suse.com>

On Fri 2024-05-31 18:06:48, Marcos Paulo de Souza wrote:
> On Fri, 2024-05-31 at 15:44 -0400, Joe Lawrence wrote:
> > On Sat, May 25, 2024 at 11:34:08AM -0300, Marcos Paulo de Souza
> > wrote:
> > > Adapt the current test-livepatch.sh script to account the number of
> > > applied livepatches and ensure that an atomic replace livepatch
> > > disables
> > > all previously applied livepatches.
> > > 
> > > Signed-off-by: Marcos Paulo de Souza <mpdesouza@suse.com>
> > > ---
> > > Changes since v1:
> > > * Added checks in the existing test-livepatch.sh instead of
> > > creating a
> > >   new test file. (Joe)
> > > * Fixed issues reported by ShellCheck (Joe)
> > > ---
> > >  .../testing/selftests/livepatch/test-livepatch.sh  | 46
> > > ++++++++++++++++++++--
> > >  1 file changed, 42 insertions(+), 4 deletions(-)
> > > 
> > > diff --git a/tools/testing/selftests/livepatch/test-livepatch.sh
> > > b/tools/testing/selftests/livepatch/test-livepatch.sh
> > > index e3455a6b1158..d85405d18e54 100755
> > > --- a/tools/testing/selftests/livepatch/test-livepatch.sh
> > > +++ b/tools/testing/selftests/livepatch/test-livepatch.sh
> > > @@ -107,9 +107,12 @@ livepatch: '$MOD_LIVEPATCH': unpatching
> > > complete
> > >  
> > >  # - load a livepatch that modifies the output from /proc/cmdline
> > > and
> > >  #   verify correct behavior
> > > -# - load an atomic replace livepatch and verify that only the
> > > second is active
> > > -# - remove the first livepatch and verify that the atomic replace
> > > livepatch
> > > -#   is still active
> > > +# - load two addtional livepatches and check the number of
> > > livepatch modules
> > > +#   applied
> > > +# - load an atomic replace livepatch and check that the other
> > > three modules were
> > > +#   disabled
> > > +# - remove all livepatches besides the atomic replace one and
> > > verify that the
> > > +#   atomic replace livepatch is still active
> > >  # - remove the atomic replace livepatch and verify that none are
> > > active
> > >  
> > >  start_test "atomic replace livepatch"
> > > @@ -119,12 +122,31 @@ load_lp $MOD_LIVEPATCH
> > >  grep 'live patched' /proc/cmdline > /dev/kmsg
> > >  grep 'live patched' /proc/meminfo > /dev/kmsg
> > >  
> > > +for mod in test_klp_syscall test_klp_callbacks_demo; do
> > 
> > Slightly nitpicky here, but the tests were originally written with
> > the
> > livepatch module names via variables like $MOD_LIVEPATCH.  Would
> > using
> > $MOD_LIVEPATCH{1,2,3} help indicate that their specifics aren't
> > really
> > interesting, that we just need 3 of them?
> 
> Makes sense. I thought about it when I was changing the code, but I
> didn't want to change it too much, so it was the result. But that makes
> sense to have the modules better named.

I like this.

> > > +	load_lp $mod
> > > +done
> > > +
> > > +mods=(/sys/kernel/livepatch/*)
> > > +nmods=${#mods[@]}
> > > +if [ "$nmods" -ne 3 ]; then
> > > +	die "Expecting three modules listed, found $nmods"
> > > +fi
> > > +
> > 
> > I was going to suggest that we might protect against a situation
> > where
> > other livepatch modules were active, that a simple count wouldn't be
> > sufficient.  But then I thought about this test, atomic replace!
> > Anything previously loaded is going to be pushed aside anyway.
> > 
> > So maybe (in another patch or set) it would be worth enhancing
> > functions.sh :: start_test() do a quick sanity check to see that the
> > initial conditions are safe?  That might also prevent some collateral
> > damage when test A fails and leaves the world a strange place for
> > tests
> > B, C, etc.
> 
> We have been discussing about start/end functions that would check for
> leftover modules... maybe should be a good think to implement soon as
> we land more tests.

Makes sense :-)

> > >  load_lp $MOD_REPLACE replace=1
> > >  
> > >  grep 'live patched' /proc/cmdline > /dev/kmsg
> > >  grep 'live patched' /proc/meminfo > /dev/kmsg
> > >  
> > > -unload_lp $MOD_LIVEPATCH
> > > +mods=(/sys/kernel/livepatch/*)
> > > +nmods=${#mods[@]}
> > > +if [ "$nmods" -ne 1 ]; then
> > > +	die "Expecting only one moduled listed, found $nmods"
> > > +fi
> > > +
> > > +# These modules were disabled by the atomic replace
> > > +for mod in test_klp_callbacks_demo test_klp_syscall
> > > $MOD_LIVEPATCH; do
> > > +	unload_lp "$mod"
> > > +done
> > >  
> > >  grep 'live patched' /proc/cmdline > /dev/kmsg
> > >  grep 'live patched' /proc/meminfo > /dev/kmsg
> > > @@ -142,6 +164,20 @@ livepatch: '$MOD_LIVEPATCH': starting patching
> > > transition
> > >  livepatch: '$MOD_LIVEPATCH': completing patching transition
> > >  livepatch: '$MOD_LIVEPATCH': patching complete
> > >  $MOD_LIVEPATCH: this has been live patched
> > > +% insmod test_modules/test_klp_syscall.ko
> > 
> > Similar minor nit here, too.  If we think copy/pasting all the
> > $MOD_FOO
> > is annoying, I am fine with leaving this as is.  I don't have a
> > strong
> > opinion other than following some convention.
> > 
> > With that, I'm happy to ack as-is or with variable names.
> 
> Thanks Joe! I think that is Petr's call, either way I can rework this
> patch, or send additional ones to adjust the tests.

I would prefer if you did respin this patch. The use of
$MOD_LIVEPATCH{1,2,3} would make even the patch easier to follow.

Best Regards,
Petr

