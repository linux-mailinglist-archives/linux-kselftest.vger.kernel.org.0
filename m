Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C1F403B4BB9
	for <lists+linux-kselftest@lfdr.de>; Sat, 26 Jun 2021 02:59:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229882AbhFZBB4 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 25 Jun 2021 21:01:56 -0400
Received: from mga14.intel.com ([192.55.52.115]:62766 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229831AbhFZBBy (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 25 Jun 2021 21:01:54 -0400
IronPort-SDR: XC3g3k9+KdVmgsOg7X9V6ssBf3Yp66C7Vj+E0XUWJH1Tgu4TPGukKp1aTEJbxydVGfFaFQwaBE
 j1kSKQnbzGrw==
X-IronPort-AV: E=McAfee;i="6200,9189,10026"; a="207579695"
X-IronPort-AV: E=Sophos;i="5.83,300,1616482800"; 
   d="scan'208";a="207579695"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Jun 2021 17:59:32 -0700
IronPort-SDR: m8c6UzKBEjURU2bi+h2NHgo9ksyz5z1IMtnKvUBrFAToc9Sn2KLNxCTPeb4duq5cTkiwKlmrZC
 eBBEOEVm0wJA==
X-IronPort-AV: E=Sophos;i="5.83,300,1616482800"; 
   d="scan'208";a="557853496"
Received: from vsampat1-mobl2.amr.corp.intel.com ([10.212.210.249])
  by fmsmga001-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Jun 2021 17:59:31 -0700
Date:   Fri, 25 Jun 2021 17:59:31 -0700 (PDT)
From:   Mat Martineau <mathew.j.martineau@linux.intel.com>
To:     Yangbo Lu <yangbo.lu@nxp.com>
cc:     netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org, mptcp@lists.linux.dev,
        Richard Cochran <richardcochran@gmail.com>,
        "David S . Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>,
        Matthieu Baerts <matthieu.baerts@tessares.net>,
        Shuah Khan <shuah@kernel.org>,
        Michal Kubecek <mkubecek@suse.cz>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Andrew Lunn <andrew@lunn.ch>, Rui Sousa <rui.sousa@nxp.com>,
        Sebastien Laveze <sebastien.laveze@nxp.com>
Subject: Re: [net-next, v4, 08/11] net: sock: extend SO_TIMESTAMPING for PHC
 binding
In-Reply-To: <20210625093513.38524-9-yangbo.lu@nxp.com>
Message-ID: <8e78961d-238f-fd22-42b-999c3647a328@linux.intel.com>
References: <20210625093513.38524-1-yangbo.lu@nxp.com> <20210625093513.38524-9-yangbo.lu@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII; format=flowed
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Fri, 25 Jun 2021, Yangbo Lu wrote:

> Since PTP virtual clock support is added, there can be
> several PTP virtual clocks based on one PTP physical
> clock for timestamping.
>
> This patch is to extend SO_TIMESTAMPING API to support
> PHC (PTP Hardware Clock) binding by adding a new flag
> SOF_TIMESTAMPING_BIND_PHC. When PTP virtual clocks are
> in use, user space can configure to bind one for
> timestamping, but PTP physical clock is not supported
> and not needed to bind.
>
> This patch is preparation for timestamp conversion from
> raw timestamp to a specific PTP virtual clock time in
> core net.
>
> Signed-off-by: Yangbo Lu <yangbo.lu@nxp.com>
> ---
> Changes for v3:
> 	- Added this patch.
> Changes for v4:
> 	- Passed so_timestamping for sock_set_timestamping.
> ---
> include/net/sock.h              |  8 +++-
> include/uapi/linux/net_tstamp.h | 17 ++++++++-
> net/core/sock.c                 | 65 +++++++++++++++++++++++++++++++--
> net/ethtool/common.c            |  1 +
> net/mptcp/sockopt.c             | 22 ++++++++---
> 5 files changed, 101 insertions(+), 12 deletions(-)
>
> diff --git a/include/net/sock.h b/include/net/sock.h
> index ced2fc965ec7..49a7858a8a03 100644
> --- a/include/net/sock.h
> +++ b/include/net/sock.h
> @@ -316,7 +316,9 @@ struct bpf_local_storage;
>   *	@sk_timer: sock cleanup timer
>   *	@sk_stamp: time stamp of last packet received
>   *	@sk_stamp_seq: lock for accessing sk_stamp on 32 bit architectures only
> -  *	@sk_tsflags: SO_TIMESTAMPING socket options
> +  *	@sk_tsflags: SO_TIMESTAMPING flags
> +  *	@sk_bind_phc: SO_TIMESTAMPING bind PHC index of PTP virtual clock
> +  *	              for timestamping
>   *	@sk_tskey: counter to disambiguate concurrent tstamp requests
>   *	@sk_zckey: counter to order MSG_ZEROCOPY notifications
>   *	@sk_socket: Identd and reporting IO signals
> @@ -493,6 +495,7 @@ struct sock {
> 	seqlock_t		sk_stamp_seq;
> #endif
> 	u16			sk_tsflags;
> +	int			sk_bind_phc;
> 	u8			sk_shutdown;
> 	u32			sk_tskey;
> 	atomic_t		sk_zckey;
> @@ -2753,7 +2756,8 @@ void sock_def_readable(struct sock *sk);
>
> int sock_bindtoindex(struct sock *sk, int ifindex, bool lock_sk);
> void sock_set_timestamp(struct sock *sk, int optname, bool valbool);
> -int sock_set_timestamping(struct sock *sk, int optname, int val);
> +int sock_set_timestamping(struct sock *sk, int optname,
> +			  struct so_timestamping timestamping);
>
> void sock_enable_timestamps(struct sock *sk);
> void sock_no_linger(struct sock *sk);
> diff --git a/include/uapi/linux/net_tstamp.h b/include/uapi/linux/net_tstamp.h
> index 7ed0b3d1c00a..fcc61c73a666 100644
> --- a/include/uapi/linux/net_tstamp.h
> +++ b/include/uapi/linux/net_tstamp.h
> @@ -13,7 +13,7 @@
> #include <linux/types.h>
> #include <linux/socket.h>   /* for SO_TIMESTAMPING */
>
> -/* SO_TIMESTAMPING gets an integer bit field comprised of these values */
> +/* SO_TIMESTAMPING flags */
> enum {
> 	SOF_TIMESTAMPING_TX_HARDWARE = (1<<0),
> 	SOF_TIMESTAMPING_TX_SOFTWARE = (1<<1),
> @@ -30,8 +30,9 @@ enum {
> 	SOF_TIMESTAMPING_OPT_STATS = (1<<12),
> 	SOF_TIMESTAMPING_OPT_PKTINFO = (1<<13),
> 	SOF_TIMESTAMPING_OPT_TX_SWHW = (1<<14),
> +	SOF_TIMESTAMPING_BIND_PHC = (1 << 15),
>
> -	SOF_TIMESTAMPING_LAST = SOF_TIMESTAMPING_OPT_TX_SWHW,
> +	SOF_TIMESTAMPING_LAST = SOF_TIMESTAMPING_BIND_PHC,
> 	SOF_TIMESTAMPING_MASK = (SOF_TIMESTAMPING_LAST - 1) |
> 				 SOF_TIMESTAMPING_LAST
> };
> @@ -46,6 +47,18 @@ enum {
> 					 SOF_TIMESTAMPING_TX_SCHED | \
> 					 SOF_TIMESTAMPING_TX_ACK)
>
> +/**
> + * struct so_timestamping - SO_TIMESTAMPING parameter
> + *
> + * @flags:	SO_TIMESTAMPING flags
> + * @bind_phc:	Index of PTP virtual clock bound to sock. This is available
> + *		if flag SOF_TIMESTAMPING_BIND_PHC is set.
> + */
> +struct so_timestamping {
> +	int flags;
> +	int bind_phc;
> +};
> +
> /**
>  * struct hwtstamp_config - %SIOCGHWTSTAMP and %SIOCSHWTSTAMP parameter
>  *
> diff --git a/net/core/sock.c b/net/core/sock.c
> index a2337b37eba6..c59b8a20dc00 100644
> --- a/net/core/sock.c
> +++ b/net/core/sock.c
> @@ -139,6 +139,8 @@
> #include <net/tcp.h>
> #include <net/busy_poll.h>
>
> +#include <linux/ethtool.h>
> +
> static DEFINE_MUTEX(proto_list_mutex);
> static LIST_HEAD(proto_list);
>
> @@ -794,8 +796,47 @@ void sock_set_timestamp(struct sock *sk, int optname, bool valbool)
> 	}
> }
>
> -int sock_set_timestamping(struct sock *sk, int optname, int val)
> +static int sock_timestamping_bind_phc(struct sock *sk, int phc_index)
> {
> +	struct net *net = sock_net(sk);
> +	struct net_device *dev = NULL;
> +	bool match = false;
> +	int *vclock_index;
> +	int i, num;
> +
> +	if (sk->sk_bound_dev_if)
> +		dev = dev_get_by_index(net, sk->sk_bound_dev_if);
> +
> +	if (!dev) {
> +		pr_err("%s: sock not bind to device\n", __func__);
> +		return -EOPNOTSUPP;
> +	}
> +
> +	num = ethtool_get_phc_vclocks(dev, &vclock_index);
> +	for (i = 0; i < num; i++) {
> +		if (*(vclock_index + i) == phc_index) {
> +			match = true;
> +			break;
> +		}
> +	}
> +
> +	if (num > 0)
> +		kfree(vclock_index);
> +
> +	if (!match)
> +		return -EINVAL;
> +
> +	sk->sk_bind_phc = phc_index;
> +
> +	return 0;
> +}
> +
> +int sock_set_timestamping(struct sock *sk, int optname,
> +			  struct so_timestamping timestamping)
> +{
> +	int val = timestamping.flags;
> +	int ret;
> +
> 	if (val & ~SOF_TIMESTAMPING_MASK)
> 		return -EINVAL;
>
> @@ -816,6 +857,12 @@ int sock_set_timestamping(struct sock *sk, int optname, int val)
> 	    !(val & SOF_TIMESTAMPING_OPT_TSONLY))
> 		return -EINVAL;
>
> +	if (val & SOF_TIMESTAMPING_BIND_PHC) {
> +		ret = sock_timestamping_bind_phc(sk, timestamping.bind_phc);
> +		if (ret)
> +			return ret;
> +	}
> +
> 	sk->sk_tsflags = val;
> 	sock_valbool_flag(sk, SOCK_TSTAMP_NEW, optname == SO_TIMESTAMPING_NEW);
>
> @@ -891,6 +938,7 @@ EXPORT_SYMBOL(sock_set_mark);
> int sock_setsockopt(struct socket *sock, int level, int optname,
> 		    sockptr_t optval, unsigned int optlen)
> {
> +	struct so_timestamping timestamping;
> 	struct sock_txtime sk_txtime;
> 	struct sock *sk = sock->sk;
> 	int val;
> @@ -1057,7 +1105,15 @@ int sock_setsockopt(struct socket *sock, int level, int optname,
>
> 	case SO_TIMESTAMPING_NEW:
> 	case SO_TIMESTAMPING_OLD:
> -		ret = sock_set_timestamping(sk, optname, val);
> +		if (optlen == sizeof(timestamping)) {
> +			if (copy_from_sockptr(&timestamping, optval,
> +					      sizeof(timestamping)))
> +				return -EFAULT;
> +		} else {
> +			memset(&timestamping, 0, sizeof(timestamping));
> +			timestamping.flags = val;
> +		}
> +		ret = sock_set_timestamping(sk, optname, timestamping);
> 		break;
>
> 	case SO_RCVLOWAT:
> @@ -1332,6 +1388,7 @@ int sock_getsockopt(struct socket *sock, int level, int optname,
> 		struct __kernel_old_timeval tm;
> 		struct  __kernel_sock_timeval stm;
> 		struct sock_txtime txtime;
> +		struct so_timestamping timestamping;
> 	} v;
>
> 	int lv = sizeof(int);
> @@ -1435,7 +1492,9 @@ int sock_getsockopt(struct socket *sock, int level, int optname,
> 		break;
>
> 	case SO_TIMESTAMPING_OLD:
> -		v.val = sk->sk_tsflags;
> +		lv = sizeof(v.timestamping);
> +		v.timestamping.flags = sk->sk_tsflags;
> +		v.timestamping.bind_phc = sk->sk_bind_phc;
> 		break;
>
> 	case SO_RCVTIMEO_OLD:
> diff --git a/net/ethtool/common.c b/net/ethtool/common.c
> index 798231b07676..c63e0739dc6a 100644
> --- a/net/ethtool/common.c
> +++ b/net/ethtool/common.c
> @@ -398,6 +398,7 @@ const char sof_timestamping_names[][ETH_GSTRING_LEN] = {
> 	[const_ilog2(SOF_TIMESTAMPING_OPT_STATS)]    = "option-stats",
> 	[const_ilog2(SOF_TIMESTAMPING_OPT_PKTINFO)]  = "option-pktinfo",
> 	[const_ilog2(SOF_TIMESTAMPING_OPT_TX_SWHW)]  = "option-tx-swhw",
> +	[const_ilog2(SOF_TIMESTAMPING_BIND_PHC)]     = "bind-phc",
> };
> static_assert(ARRAY_SIZE(sof_timestamping_names) == __SOF_TIMESTAMPING_CNT);
>
> diff --git a/net/mptcp/sockopt.c b/net/mptcp/sockopt.c
> index ea38cbcd2ad4..e20aefc20d75 100644
> --- a/net/mptcp/sockopt.c
> +++ b/net/mptcp/sockopt.c
> @@ -207,14 +207,26 @@ static int mptcp_setsockopt_sol_socket_timestamping(struct mptcp_sock *msk,
> {
> 	struct mptcp_subflow_context *subflow;
> 	struct sock *sk = (struct sock *)msk;
> +	struct so_timestamping timestamping;
> 	int val, ret;
>
> -	ret = mptcp_get_int_option(msk, optval, optlen, &val);
> -	if (ret)
> -		return ret;
> +	if (optlen == sizeof(timestamping)) {
> +		if (copy_from_sockptr(&timestamping, optval,
> +				      sizeof(timestamping)))
> +			return -EFAULT;
> +	} else if (optlen == sizeof(int)) {
> +		if (copy_from_sockptr(val, optval, sizeof(*val)))
                                       ^^^

As the kbuild bot noted, this needs to be a pointer. You could pass in 
&timestamping.flags and you wouldn't need the 'val' variable at all.


-Mat


> +			return -EFAULT;
> +
> +		memset(&timestamping, 0, sizeof(timestamping));
> +		timestamping.flags = val;
> +	} else {
> +		return -EINVAL;
> +	}
>
> 	ret = sock_setsockopt(sk->sk_socket, SOL_SOCKET, optname,
> -			      KERNEL_SOCKPTR(&val), sizeof(val));
> +			      KERNEL_SOCKPTR(&timestamping),
> +			      sizeof(timestamping));
> 	if (ret)
> 		return ret;
>
> @@ -224,7 +236,7 @@ static int mptcp_setsockopt_sol_socket_timestamping(struct mptcp_sock *msk,
> 		struct sock *ssk = mptcp_subflow_tcp_sock(subflow);
> 		bool slow = lock_sock_fast(ssk);
>
> -		sock_set_timestamping(sk, optname, val);
> +		sock_set_timestamping(sk, optname, timestamping);
> 		unlock_sock_fast(ssk, slow);
> 	}
>
> -- 
> 2.25.1
>
>

--
Mat Martineau
Intel
