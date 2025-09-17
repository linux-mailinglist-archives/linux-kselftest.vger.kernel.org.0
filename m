Return-Path: <linux-kselftest+bounces-41787-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5BF1DB821E0
	for <lists+linux-kselftest@lfdr.de>; Thu, 18 Sep 2025 00:12:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E17FB1C80135
	for <lists+linux-kselftest@lfdr.de>; Wed, 17 Sep 2025 22:13:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D118630DEC0;
	Wed, 17 Sep 2025 22:12:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Fq99C4CH"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A28730CD81;
	Wed, 17 Sep 2025 22:12:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758147153; cv=none; b=HFaGHD6VfSp8TfjPh9PLZ7Hs554OX8DiOsztUCQ0I5puQZVsK+Zapwd5tOZ7i9xbZRbWo2xqrKDYYbk3Ezvb9V+CX8cK4MQoBjf4vefcexOWwXd2SQrhMMPCRJeaCUxBJElvFaRdum1mOyBIlyFQLMsCeSJG62LCPYikozxV0jE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758147153; c=relaxed/simple;
	bh=jZp3N4yfbt6bvqKivm7Q5Md9rUK3bDVNKY5H7aGaV+M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=en78npC+rAX9eF9WeSQJ8uMJPczV1k8T+y0kpTSF2PQuPE0WGa4HthOHpVEV5B5kDlnr5+ALTLvrV1YfRba3kUvMvE/cJFn9AhUxKuvGGwkEikhh5TdcJYgwn1IkXU+Ig1HZCoBDe6Nbt+DLRori/2sNTbHanQ3vV2vuGyR9TFQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Fq99C4CH; arc=none smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1758147152; x=1789683152;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=jZp3N4yfbt6bvqKivm7Q5Md9rUK3bDVNKY5H7aGaV+M=;
  b=Fq99C4CHFd3rYpR5hA6FXZdB7f+De5td5vjPEUw42OB5Ytob1DGDsPzh
   EnIuyDAFeda5ktL8F0IIyUgDUCw/W93LyjludrwCXmyfBLXzKLK+p8H5F
   G3JimJ7bMRNY4tV76p0vET/DvrS86IQD9CSN6vPgTuPbKNUf9oEV8145M
   OU+YEc2hVNXFbxAQEGThv97GKVzKX/SeheQS1YS8hA5YBK+1Cew3LTIyX
   GsRqRzFaReVxuxxnm+/VeMPPIzRNDtYNzALv+DBMsoAvKVt2Ljtwmue2T
   3wvyO4J4ouyKanwJbwRyciHS/ObZeilz55OANGG563IWOGERr0w6iP6Bn
   w==;
X-CSE-ConnectionGUID: DTzcPlaaQFGqNGLJVx0eiQ==
X-CSE-MsgGUID: 9mSHxz9cTdWa9ceZc7ok3A==
X-IronPort-AV: E=McAfee;i="6800,10657,11531"; a="60417092"
X-IronPort-AV: E=Sophos;i="6.17,312,1747724400"; 
   d="scan'208";a="60417092"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Sep 2025 15:12:31 -0700
X-CSE-ConnectionGUID: MqFrv36QTHKL0YfvttMEsg==
X-CSE-MsgGUID: i6jXJOllTwSCTYOM/OP7zA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,273,1751266800"; 
   d="scan'208";a="176142295"
Received: from lkp-server01.sh.intel.com (HELO 84a20bd60769) ([10.239.97.150])
  by fmviesa010.fm.intel.com with ESMTP; 17 Sep 2025 15:12:25 -0700
Received: from kbuild by 84a20bd60769 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1uz0Nz-0002Vv-1B;
	Wed, 17 Sep 2025 22:12:23 +0000
Date: Thu, 18 Sep 2025 06:12:19 +0800
From: kernel test robot <lkp@intel.com>
To: Bobby Eshleman <bobbyeshleman@gmail.com>,
	Stefano Garzarella <sgarzare@redhat.com>,
	Shuah Khan <skhan@linuxfoundation.org>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Stefan Hajnoczi <stefanha@redhat.com>,
	"Michael S. Tsirkin" <mst@redhat.com>,
	Jason Wang <jasowang@redhat.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	Eugenio =?iso-8859-1?Q?P=E9rez?= <eperezma@redhat.com>,
	"K. Y. Srinivasan" <kys@microsoft.com>,
	Haiyang Zhang <haiyangz@microsoft.com>,
	Wei Liu <wei.liu@kernel.org>, Dexuan Cui <decui@microsoft.com>,
	Bryan Tan <bryan-bt.tan@broadcom.com>,
	Vishnu Dasa <vishnu.dasa@broadcom.com>,
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>
Cc: oe-kbuild-all@lists.linux.dev, netdev@vger.kernel.org,
	virtualization@lists.linux.dev, linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org, kvm@vger.kernel.org,
	linux-hyperv@vger.kernel.org,
	Bobby Eshleman <bobbyeshleman@gmail.com>, berrange@redhat.com
Subject: Re: [PATCH net-next v6 3/9] vsock: add netns to vsock core
Message-ID: <202509180511.5pJaP7gr-lkp@intel.com>
References: <20250916-vsock-vmtest-v6-3-064d2eb0c89d@meta.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250916-vsock-vmtest-v6-3-064d2eb0c89d@meta.com>

Hi Bobby,

kernel test robot noticed the following build errors:

[auto build test ERROR on 949ddfb774fe527cebfa3f769804344940f7ed2e]

url:    https://github.com/intel-lab-lkp/linux/commits/Bobby-Eshleman/vsock-a-per-net-vsock-NS-mode-state/20250917-074823
base:   949ddfb774fe527cebfa3f769804344940f7ed2e
patch link:    https://lore.kernel.org/r/20250916-vsock-vmtest-v6-3-064d2eb0c89d%40meta.com
patch subject: [PATCH net-next v6 3/9] vsock: add netns to vsock core
config: i386-allmodconfig (https://download.01.org/0day-ci/archive/20250918/202509180511.5pJaP7gr-lkp@intel.com/config)
compiler: gcc-14 (Debian 14.2.0-19) 14.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20250918/202509180511.5pJaP7gr-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202509180511.5pJaP7gr-lkp@intel.com/

All errors (new ones prefixed by >>):

   net/vmw_vsock/hyperv_transport.c: In function 'hvs_open_connection':
>> net/vmw_vsock/hyperv_transport.c:316:14: error: too few arguments to function 'vsock_find_bound_socket'
     316 |         sk = vsock_find_bound_socket(&addr, vsock_global_dummy_net());
         |              ^~~~~~~~~~~~~~~~~~~~~~~
   In file included from net/vmw_vsock/hyperv_transport.c:15:
   include/net/af_vsock.h:218:14: note: declared here
     218 | struct sock *vsock_find_bound_socket(struct sockaddr_vm *addr, struct net *net,
         |              ^~~~~~~~~~~~~~~~~~~~~~~


vim +/vsock_find_bound_socket +316 net/vmw_vsock/hyperv_transport.c

   294	
   295	static void hvs_open_connection(struct vmbus_channel *chan)
   296	{
   297		guid_t *if_instance, *if_type;
   298		unsigned char conn_from_host;
   299	
   300		struct sockaddr_vm addr;
   301		struct sock *sk, *new = NULL;
   302		struct vsock_sock *vnew = NULL;
   303		struct hvsock *hvs = NULL;
   304		struct hvsock *hvs_new = NULL;
   305		int rcvbuf;
   306		int ret;
   307		int sndbuf;
   308	
   309		if_type = &chan->offermsg.offer.if_type;
   310		if_instance = &chan->offermsg.offer.if_instance;
   311		conn_from_host = chan->offermsg.offer.u.pipe.user_def[0];
   312		if (!is_valid_srv_id(if_type))
   313			return;
   314	
   315		hvs_addr_init(&addr, conn_from_host ? if_type : if_instance);
 > 316		sk = vsock_find_bound_socket(&addr, vsock_global_dummy_net());
   317		if (!sk)
   318			return;
   319	
   320		lock_sock(sk);
   321		if ((conn_from_host && sk->sk_state != TCP_LISTEN) ||
   322		    (!conn_from_host && sk->sk_state != TCP_SYN_SENT))
   323			goto out;
   324	
   325		if (conn_from_host) {
   326			if (sk->sk_ack_backlog >= sk->sk_max_ack_backlog)
   327				goto out;
   328	
   329			new = vsock_create_connected(sk);
   330			if (!new)
   331				goto out;
   332	
   333			new->sk_state = TCP_SYN_SENT;
   334			vnew = vsock_sk(new);
   335	
   336			hvs_addr_init(&vnew->local_addr, if_type);
   337	
   338			/* Remote peer is always the host */
   339			vsock_addr_init(&vnew->remote_addr,
   340					VMADDR_CID_HOST, VMADDR_PORT_ANY);
   341			vnew->remote_addr.svm_port = get_port_by_srv_id(if_instance);
   342			ret = vsock_assign_transport(vnew, vsock_sk(sk));
   343			/* Transport assigned (looking at remote_addr) must be the
   344			 * same where we received the request.
   345			 */
   346			if (ret || !hvs_check_transport(vnew)) {
   347				sock_put(new);
   348				goto out;
   349			}
   350			hvs_new = vnew->trans;
   351			hvs_new->chan = chan;
   352		} else {
   353			hvs = vsock_sk(sk)->trans;
   354			hvs->chan = chan;
   355		}
   356	
   357		set_channel_read_mode(chan, HV_CALL_DIRECT);
   358	
   359		/* Use the socket buffer sizes as hints for the VMBUS ring size. For
   360		 * server side sockets, 'sk' is the parent socket and thus, this will
   361		 * allow the child sockets to inherit the size from the parent. Keep
   362		 * the mins to the default value and align to page size as per VMBUS
   363		 * requirements.
   364		 * For the max, the socket core library will limit the socket buffer
   365		 * size that can be set by the user, but, since currently, the hv_sock
   366		 * VMBUS ring buffer is physically contiguous allocation, restrict it
   367		 * further.
   368		 * Older versions of hv_sock host side code cannot handle bigger VMBUS
   369		 * ring buffer size. Use the version number to limit the change to newer
   370		 * versions.
   371		 */
   372		if (vmbus_proto_version < VERSION_WIN10_V5) {
   373			sndbuf = RINGBUFFER_HVS_SND_SIZE;
   374			rcvbuf = RINGBUFFER_HVS_RCV_SIZE;
   375		} else {
   376			sndbuf = max_t(int, sk->sk_sndbuf, RINGBUFFER_HVS_SND_SIZE);
   377			sndbuf = min_t(int, sndbuf, RINGBUFFER_HVS_MAX_SIZE);
   378			sndbuf = ALIGN(sndbuf, HV_HYP_PAGE_SIZE);
   379			rcvbuf = max_t(int, sk->sk_rcvbuf, RINGBUFFER_HVS_RCV_SIZE);
   380			rcvbuf = min_t(int, rcvbuf, RINGBUFFER_HVS_MAX_SIZE);
   381			rcvbuf = ALIGN(rcvbuf, HV_HYP_PAGE_SIZE);
   382		}
   383	
   384		chan->max_pkt_size = HVS_MAX_PKT_SIZE;
   385	
   386		ret = vmbus_open(chan, sndbuf, rcvbuf, NULL, 0, hvs_channel_cb,
   387				 conn_from_host ? new : sk);
   388		if (ret != 0) {
   389			if (conn_from_host) {
   390				hvs_new->chan = NULL;
   391				sock_put(new);
   392			} else {
   393				hvs->chan = NULL;
   394			}
   395			goto out;
   396		}
   397	
   398		set_per_channel_state(chan, conn_from_host ? new : sk);
   399	
   400		/* This reference will be dropped by hvs_close_connection(). */
   401		sock_hold(conn_from_host ? new : sk);
   402		vmbus_set_chn_rescind_callback(chan, hvs_close_connection);
   403	
   404		/* Set the pending send size to max packet size to always get
   405		 * notifications from the host when there is enough writable space.
   406		 * The host is optimized to send notifications only when the pending
   407		 * size boundary is crossed, and not always.
   408		 */
   409		hvs_set_channel_pending_send_size(chan);
   410	
   411		if (conn_from_host) {
   412			new->sk_state = TCP_ESTABLISHED;
   413			sk_acceptq_added(sk);
   414	
   415			hvs_new->vm_srv_id = *if_type;
   416			hvs_new->host_srv_id = *if_instance;
   417	
   418			vsock_insert_connected(vnew);
   419	
   420			vsock_enqueue_accept(sk, new);
   421		} else {
   422			sk->sk_state = TCP_ESTABLISHED;
   423			sk->sk_socket->state = SS_CONNECTED;
   424	
   425			vsock_insert_connected(vsock_sk(sk));
   426		}
   427	
   428		sk->sk_state_change(sk);
   429	
   430	out:
   431		/* Release refcnt obtained when we called vsock_find_bound_socket() */
   432		sock_put(sk);
   433	
   434		release_sock(sk);
   435	}
   436	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

