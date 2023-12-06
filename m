Return-Path: <linux-kselftest+bounces-1224-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 26653806545
	for <lists+linux-kselftest@lfdr.de>; Wed,  6 Dec 2023 03:48:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CD19128228F
	for <lists+linux-kselftest@lfdr.de>; Wed,  6 Dec 2023 02:48:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E9696D22;
	Wed,  6 Dec 2023 02:48:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="R01iuJxL"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pf1-x435.google.com (mail-pf1-x435.google.com [IPv6:2607:f8b0:4864:20::435])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B68CE1A2;
	Tue,  5 Dec 2023 18:48:33 -0800 (PST)
Received: by mail-pf1-x435.google.com with SMTP id d2e1a72fcca58-6ce52ff23dfso361252b3a.0;
        Tue, 05 Dec 2023 18:48:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1701830913; x=1702435713; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=ogka+BvCza9TVWp5K8/aCslfOSdnFwmW67J3MECnwfs=;
        b=R01iuJxL3CirOXnZz3rEkpduGRO5vCAEhlyWH+SDEkBvljXPUX7WFATZtftCwp/PlJ
         I4WEhYNobbWyU5+zGSmNw0yWQDu7iLqh2dSYWoYHRp/XeOeWMC2vANL1mCHIOYkhNebi
         eJ7WKaOHojrRi27wpqkX1u9Qxm53aB7lk9+BGB2eWAw/aRJ/S1+IchUX0An5uzRnstRD
         rhzrfOPvvrgWKjTM04ZG3PVyWacRZu3KxV4LUiKzv1frzCxHWR28srRVnqoj5M/eMExw
         C/jxdnSrZ14ZSkfoyztddFZo1tztlAs6WWXgvBITHLhLlyfHsyy1AJ754cAFEWl4bbDD
         nPug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701830913; x=1702435713;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ogka+BvCza9TVWp5K8/aCslfOSdnFwmW67J3MECnwfs=;
        b=a3ZuPKBfJ75V68cMGiBM6d3B1vE2uWPLbS+XZXXf8E2BjQQuRwfiGb6qnF7U+L91rP
         lTN4WyI4uZdY96FAJGYFvrpgEFzyXJdcSRWhJF3XCS9VBHr6on6QF+v/bPb1DV9nCsaY
         gX92Dl4ZPVHZb6ByeTxSXwNlXZUhgdZvpy3yl97WhBakay7zZTndFCStU6w8XAzF9zTM
         lWPpCcuts2LAlM0r8eBOwNyylzc77D8g5XgyGJLKbBNS+w7IWgb1cPEbjrAAT6bkKHlj
         wgqUVMtmiNbd8ZpQfITVBzpwR1F1wtCB4HLGUYez8+pEqEpxaGg4XVIMzKIvgC0rRqHS
         kcPg==
X-Gm-Message-State: AOJu0YxKnvpPGHvasC2BIQpNWjhq/dsRvs85bku3/oSj3LTPbNNGDPzo
	Kk7IYyAJp92Q0eglx4rBj14=
X-Google-Smtp-Source: AGHT+IFc1Se7YJW9EQzzdr3+Da3Mguzwub8+qaSA85sAx3k+jdog5hBB4HS4fkB4HxH708O5I3HzDg==
X-Received: by 2002:a05:6a00:238c:b0:6ce:939e:bed6 with SMTP id f12-20020a056a00238c00b006ce939ebed6mr114201pfc.34.1701830913027;
        Tue, 05 Dec 2023 18:48:33 -0800 (PST)
Received: from Laptop-X1 ([43.228.180.230])
        by smtp.gmail.com with ESMTPSA id p23-20020aa78617000000b006ce742b6b1fsm1646551pfn.63.2023.12.05.18.48.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Dec 2023 18:48:32 -0800 (PST)
Date: Wed, 6 Dec 2023 10:48:26 +0800
From: Hangbin Liu <liuhangbin@gmail.com>
To: Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org, "David S. Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>,
	Eric Dumazet <edumazet@google.com>, Shuah Khan <shuah@kernel.org>,
	David Ahern <dsahern@kernel.org>, linux-kselftest@vger.kernel.org,
	Po-Hsu Lin <po-hsu.lin@canonical.com>,
	Guillaume Nault <gnault@redhat.com>,
	Petr Machata <petrm@nvidia.com>,
	James Prestwood <prestwoj@gmail.com>,
	Jaehee Park <jhpark1013@gmail.com>,
	Ido Schimmel <idosch@nvidia.com>,
	Justin Iurman <justin.iurman@uliege.be>,
	Xin Long <lucien.xin@gmail.com>,
	James Chapman <jchapman@katalix.com>
Subject: Re: [PATCHv3 net-next 01/14] selftests/net: add lib.sh
Message-ID: <ZW_g-g1Rd0FA95fU@Laptop-X1>
References: <20231202020110.362433-1-liuhangbin@gmail.com>
 <20231202020110.362433-2-liuhangbin@gmail.com>
 <7e73dbfe6cad7d551516d02bb02881d885045498.camel@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7e73dbfe6cad7d551516d02bb02881d885045498.camel@redhat.com>

On Tue, Dec 05, 2023 at 01:00:29PM +0100, Paolo Abeni wrote:
> > +cleanup_ns()
> > +{
> > +	local ns=""
> > +	local errexit=0
> > +	local ret=0
> > +
> > +	# disable errexit temporary
> > +	if [[ $- =~ "e" ]]; then
> > +		errexit=1
> > +		set +e
> > +	fi
> > +
> > +	for ns in "$@"; do
> > +		ip netns delete "${ns}" &> /dev/null
> > +		if ! busywait 2 ip netns list \| grep -vq "^$ns$" &> /dev/null; then
> > +			echo "Warn: Failed to remove namespace $ns"
> > +			ret=1
> > +		fi
> > +	done
> > +
> > +	[ $errexit -eq 1 ] && set -e
> > +	return $ret
> > +}
> > +
> > +# setup netns with given names as prefix. e.g
> > +# setup_ns local remote
> > +setup_ns()
> > +{
> > +	local ns=""
> > +	local ns_name=""
> > +	local ns_list=""
> > +	for ns_name in "$@"; do
> > +		# Some test may setup/remove same netns multi times
> > +		if unset ${ns_name} 2> /dev/null; then
> > +			ns="${ns_name,,}-$(mktemp -u XXXXXX)"
> > +			eval readonly ${ns_name}="$ns"
> > +		else
> > +			eval ns='$'${ns_name}
> > +			cleanup_ns "$ns"
> > +
> > +		fi
> > +
> > +		if ! ip netns add "$ns"; then
> > +			echo "Failed to create namespace $ns_name"
> > +			cleanup_ns "$ns_list"
> > +			return $ksft_skip
> > +		fi
> > +		ip -n "$ns" link set lo up
> > +		ns_list="$ns_list $ns"
> 
> Side note for a possible follow-up: if you maintain $ns_list as global
> variable, and remove from such list the ns deleted by cleanup_ns, you
> could remove the cleanup trap from the individual test with something
> alike:
> 
> final_cleanup_ns()
> {
> 	cleanup_ns $ns_list
> }
> 
> trap final_cleanup_ns EXIT
> 
> No respin needed for the above, could be a follow-up if agreed upon.

Hi Paolo,

I did similar in the first version. But Petr said[1] we should let the
client do cleanup specifically. I agree that we should let client script
keep this in mind.

On the other hand, maybe we can add this final cleanup and let client call
it directly. What do you think?

[1] https://lore.kernel.org/netdev/878r6nf9x5.fsf@nvidia.com/

Thanks
Hangbin

