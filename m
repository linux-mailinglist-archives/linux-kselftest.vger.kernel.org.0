Return-Path: <linux-kselftest+bounces-602-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 784567F8899
	for <lists+linux-kselftest@lfdr.de>; Sat, 25 Nov 2023 07:15:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D3496281363
	for <lists+linux-kselftest@lfdr.de>; Sat, 25 Nov 2023 06:15:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6092A2106;
	Sat, 25 Nov 2023 06:15:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="b77ff2OP"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-oi1-x233.google.com (mail-oi1-x233.google.com [IPv6:2607:f8b0:4864:20::233])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6EE611723;
	Fri, 24 Nov 2023 22:15:48 -0800 (PST)
Received: by mail-oi1-x233.google.com with SMTP id 5614622812f47-3b83432ca31so1683316b6e.1;
        Fri, 24 Nov 2023 22:15:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1700892948; x=1701497748; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=pt0PfJDT3f08sVVp/8Q0IRjtVu02ZOwmgKKrULlYRLU=;
        b=b77ff2OPt4P/0UMdskPrRxSBt/7A/RBbH008dvXmOKr3HBcMdkHaK0jrO02Thal+db
         06aEzkTcwrr7dZ+URQBqx2IQpcFxin6oILZbP4lND8Iqj6/xNK0WaFbGv7u1FWp9w2qA
         n2o5HPDJg2j113P44dk6PmM24FFT+Dk0o7T6q489T5iYj51MpxHLGfvl8UfEiYCgLies
         ZPIT+92fe/gR6QW/Xvm1ZxsygCeM9E2JMXNDP/Gl/AnadYwZsdwusYjNHQ+Ef7WFU1Ba
         CvfBM9FPpFk/gfqiF8T0/Zh67CbvlgUKjCyGzwCz11WmewSP8TU5673R4Yy1XF0qmlB7
         48yg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700892948; x=1701497748;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pt0PfJDT3f08sVVp/8Q0IRjtVu02ZOwmgKKrULlYRLU=;
        b=u4uAX6H0VBUyaLUXQlA1cnMl3Jm0pNWfpzNS8INBaSNgxAvvlGsZ2PMq3pLePCa+wA
         jSAOiWx6kMr0fzFQ5JzE32jNZjn7LpH7O6Z3vCp2X7+RIDgqZEmxzQ0aDs42M7lrZiYG
         bE2YC59kJ431YUKAl/uKlCEG/slO10JIOWtzeuMcyHc6shoZcze/O8kwmXXkqzNdwecZ
         O62S/tUT/Ne9/nAQhTft1qRMVovVrF+yr1xJdfhg62F7ZvDGaI9FAnUdZtPVDOlcB031
         j+3d39l5e3Gw6GDU0vmylufLhK8K90wT6sq25MrYXuX7rcWHfMn/TiLd+yJ7xEZjnKFd
         i45w==
X-Gm-Message-State: AOJu0YxxEc1CAytYM0m3ufqCO8dscPIOVp7NB4V6IPK6+rbIfBTzhwWX
	fIAG45RmrzY2iCzVCjqZrCs=
X-Google-Smtp-Source: AGHT+IFrTu+HMFY2tW90QAa4w1v6C4Hg0ZSYs6mEUVIn4e6O+bbYT5Dep6SV6Oj0Mt53DR8e9mpyKQ==
X-Received: by 2002:a05:6808:dde:b0:3b8:5df8:be90 with SMTP id g30-20020a0568080dde00b003b85df8be90mr576069oic.53.1700892947775;
        Fri, 24 Nov 2023 22:15:47 -0800 (PST)
Received: from Laptop-X1 ([43.228.180.230])
        by smtp.gmail.com with ESMTPSA id v69-20020a638948000000b0056c2f1a2f6bsm4041740pgd.41.2023.11.24.22.15.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Nov 2023 22:15:45 -0800 (PST)
Date: Sat, 25 Nov 2023 14:15:36 +0800
From: Hangbin Liu <liuhangbin@gmail.com>
To: Petr Machata <petrm@nvidia.com>
Cc: netdev@vger.kernel.org, "David S. Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>,
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
	Shuah Khan <shuah@kernel.org>, David Ahern <dsahern@kernel.org>,
	linux-kselftest@vger.kernel.org,
	Po-Hsu Lin <po-hsu.lin@canonical.com>,
	Guillaume Nault <gnault@redhat.com>,
	=?iso-8859-1?Q?Bj=F6rn_T=F6pel?= <bjorn@rivosinc.com>,
	Ryan Roberts <ryan.roberts@arm.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Mark Brown <broonie@kernel.org>,
	Luis Chamberlain <mcgrof@kernel.org>
Subject: Re: [PATCH net-next 01/38] selftests/net: add lib.sh
Message-ID: <ZWGRCK4D64EfUybp@Laptop-X1>
References: <20231124092736.3673263-1-liuhangbin@gmail.com>
 <20231124092736.3673263-2-liuhangbin@gmail.com>
 <87cyvzfagj.fsf@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87cyvzfagj.fsf@nvidia.com>

On Fri, Nov 24, 2023 at 03:35:51PM +0100, Petr Machata wrote:
> 
> Hangbin Liu <liuhangbin@gmail.com> writes:
> 
> > +cleanup_ns()
> > +{
> > +	local ns=""
> > +	local errexit=0
> > +
> > +	# disable errexit temporary
> > +	if [[ $- =~ "e" ]]; then
> > +		errexit=1
> > +		set +e
> > +	fi
> > +
> > +	for ns in "$@"; do
> > +		ip netns delete "${ns}" &> /dev/null
> > +		busywait 2 "ip netns list | grep -vq $1" &> /dev/null
> 
> The grep would get confused by substrings of other names.
> This should be grep -vq "^$ns$".

Thanks. I just thought the ns name would like foo-xxxxxxx, but I forgot this
is a common function, which maybe called with normal ns name.

> 
> > +		if ip netns list | grep -q $1; then
> 
> Busywait returns != 0 when the wait condition is not reached within a
> given time. So it should be possible to roll the duplicated if-grep into
> the busywait line like so:
> 
> 		if ! busywait 2 "ip netns etc."; then

You are right.
> 
> > +			echo "Failed to remove namespace $1"
> > +			return $ksft_skip
> 
> This does not restore the errexit.
> 
> I think it might be clearest to have this function as a helper, say
> __cleanup_ns, and then have a wrapper that does the errexit management:
> 
> cleanup_ns()
> {
> 	local errexit
> 	local rc
> 
> 	# disable errexit temporarily
> 	if [[ $- =~ "e" ]]; then
> 		errexit=1
> 		set +e
> 	fi
> 
> 	__cleanup_ns "$@"
> 	rc=$?
> 
> 	[ $errexit -eq 1 ] && set -e
> 	return $rc
> }
> 
> If this comes up more often, we can have a helper like
> with_disabled_errexit or whatever, that does this management and
> dispatches to "$@", so cleanup_ns() would become:
> 
> cleanup_ns()
> {
> 	with_disabled_errexit __cleanup_ns "$@"
> }

Thanks for your suggestion.

> 
> > +		fi
> > +	done
> > +
> > +	[ $errexit -eq 1 ] && set -e
> > +	return 0
> > +}
> > +
> > +# By default, remove all netns before EXIT.
> > +cleanup_all_ns()
> > +{
> > +	cleanup_ns $NS_LIST
> > +}
> > +trap cleanup_all_ns EXIT
> 
> Hmm, OK, this is a showstopper for inclusion from forwarding/lib.sh,
> because basically all users of forwarding/lib.sh use the EXIT trap.
> 
> I wonder if we need something like these push_cleanup / on_exit helpers:
> 
> 	https://github.com/pmachata/stuff/blob/master/ptp-test/lib.sh#L15

When I added this, I just want to make sure the netns are cleaned up if the
client script forgot. I think the client script trap function should
cover this one, no?

> 
> But I don't want to force this on your already large patchset :)

Yes, Paolo also told me that this is too large. I will break it to
2 path set or merge some small patches together for next version.

> So just ignore the bit about including from forwarding/lib.sh.

> Actually I take this back. The cleanup should be invoked from where the
> init was called. I don't think the library should be auto-invoking it,
> the client scripts should. Whether through a trap or otherwise.

OK, also makes sense. I will remove this trap.

Thanks for all your comments.
Hangbin

