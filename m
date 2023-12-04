Return-Path: <linux-kselftest+bounces-1035-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D0544802D1B
	for <lists+linux-kselftest@lfdr.de>; Mon,  4 Dec 2023 09:26:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 89069280C78
	for <lists+linux-kselftest@lfdr.de>; Mon,  4 Dec 2023 08:25:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9AB1ADF64;
	Mon,  4 Dec 2023 08:25:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=secunet.com header.i=@secunet.com header.b="KwWu3Bpt"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from a.mx.secunet.com (a.mx.secunet.com [62.96.220.36])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 320DFFE;
	Mon,  4 Dec 2023 00:25:50 -0800 (PST)
Received: from localhost (localhost [127.0.0.1])
	by a.mx.secunet.com (Postfix) with ESMTP id E4AA3204D9;
	Mon,  4 Dec 2023 09:25:47 +0100 (CET)
X-Virus-Scanned: by secunet
Received: from a.mx.secunet.com ([127.0.0.1])
	by localhost (a.mx.secunet.com [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id hvPwaSxxYUiK; Mon,  4 Dec 2023 09:25:47 +0100 (CET)
Received: from mailout2.secunet.com (mailout2.secunet.com [62.96.220.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by a.mx.secunet.com (Postfix) with ESMTPS id 4C40920078;
	Mon,  4 Dec 2023 09:25:47 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 a.mx.secunet.com 4C40920078
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=secunet.com;
	s=202301; t=1701678347;
	bh=6LGB45I5byCoMEvvTmFWKfhjgGrm1+u7IAc5pF3fXcc=;
	h=Date:From:To:CC:Subject:References:In-Reply-To:From;
	b=KwWu3BptcKE5mMLWl8mHeIi9qJxIyxohZ3pyPiU8GufgBcZRy11AsRCirUPTY3RQ5
	 VCuwAOdD4D+GLjwzzqx1CbPm/IV7UUyKjO5zDaHy7JJ76KnHdWhkYiJBa1+jQVCd8/
	 WhCMr8qRJOI7Oe6Z6dM/unK4csL4qMFT2PaB9f4kbIaooD4Ks7XPzx6bo99hCXx/Pv
	 B9U4v3BDF/XeDlHwKkMgRtWDKt0SX0DWReAbIC1e+0lAfqcmxD1TmpeUi6WkrEFUHl
	 D0oGMrMRGiFTY9e/9xvWryQ0LkLVPlrF2/+GQIVr9TUbardkk3RRGkhURoBQiqNKzU
	 5owz2QNMth0Qg==
Received: from cas-essen-02.secunet.de (unknown [10.53.40.202])
	by mailout2.secunet.com (Postfix) with ESMTP id 164F580004A;
	Mon,  4 Dec 2023 09:25:47 +0100 (CET)
Received: from mbx-essen-02.secunet.de (10.53.40.198) by
 cas-essen-02.secunet.de (10.53.40.202) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34; Mon, 4 Dec 2023 09:25:46 +0100
Received: from gauss2.secunet.de (10.182.7.193) by mbx-essen-02.secunet.de
 (10.53.40.198) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.34; Mon, 4 Dec
 2023 09:25:46 +0100
Received: by gauss2.secunet.de (Postfix, from userid 1000)
	id 49F6131811E6; Mon,  4 Dec 2023 09:25:46 +0100 (CET)
Date: Mon, 4 Dec 2023 09:25:46 +0100
From: Steffen Klassert <steffen.klassert@secunet.com>
To: Daniel Xu <dxu@dxuuu.xyz>
CC: Alexei Starovoitov <alexei.starovoitov@gmail.com>, Network Development
	<netdev@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>, bpf
	<bpf@vger.kernel.org>, clang-built-linux <llvm@lists.linux.dev>, "open
 list:KERNEL SELFTEST FRAMEWORK" <linux-kselftest@vger.kernel.org>,
	<antony.antony@secunet.com>, Yonghong Song <yonghong.song@linux.dev>, Eddy Z
	<eddyz87@gmail.com>, <devel@linux-ipsec.org>, Eyal Birger
	<eyal.birger@gmail.com>
Subject: Re: [PATCH ipsec-next v3 0/9] Add bpf_xdp_get_xfrm_state() kfunc
Message-ID: <ZW2NCm/pIthdpNgF@gauss3.secunet.de>
References: <cover.1701462010.git.dxu@dxuuu.xyz>
 <CAADnVQKWrvec6ap_7O0Z5uAJe-pdrhuJk8LRkmWvGMM4iF9Frg@mail.gmail.com>
 <dkzlpw6sj7we5xteyvbwxufqzg6axwlrvb4arq23ecaiy5ayok@jg52fqjr4ftf>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <dkzlpw6sj7we5xteyvbwxufqzg6axwlrvb4arq23ecaiy5ayok@jg52fqjr4ftf>
X-ClientProxiedBy: cas-essen-02.secunet.de (10.53.40.202) To
 mbx-essen-02.secunet.de (10.53.40.198)
X-EXCLAIMER-MD-CONFIG: 2c86f778-e09b-4440-8b15-867914633a10

On Fri, Dec 01, 2023 at 05:16:04PM -0700, Daniel Xu wrote:
> On Fri, Dec 01, 2023 at 04:10:18PM -0800, Alexei Starovoitov wrote:
> > On Fri, Dec 1, 2023 at 12:23 PM Daniel Xu <dxu@dxuuu.xyz> wrote:
> > >
> > >  include/net/xfrm.h                            |   9 +
> > >  net/xfrm/Makefile                             |   1 +
> > >  net/xfrm/xfrm_policy.c                        |   2 +
> > >  net/xfrm/xfrm_state_bpf.c                     | 128 ++++++++++++++
> > >  tools/lib/bpf/bpf_core_read.h                 |  34 ++++
> > >  .../selftests/bpf/prog_tests/test_tunnel.c    | 162 +++++++++++++++++-
> > >  .../selftests/bpf/prog_tests/verifier.c       |   2 +
> > >  tools/testing/selftests/bpf/progs/bpf_misc.h  |   1 +
> > >  .../selftests/bpf/progs/bpf_tracing_net.h     |   1 +
> > >  .../selftests/bpf/progs/test_tunnel_kern.c    | 138 ++++++++-------
> > >  .../bpf/progs/verifier_bitfield_write.c       | 100 +++++++++++
> > >  tools/testing/selftests/bpf/test_loader.c     |   7 +
> > >  tools/testing/selftests/bpf/test_tunnel.sh    |  92 ----------
> > >  13 files changed, 522 insertions(+), 155 deletions(-)
> > 
> > I really think this should go via bpf-next tree.
> > The bpf changes are much bigger than ipsec.
> 
> Ack. Ended up picking up a lot of stuff along the way.

I'm fine with merging this via the bpf-next tree.

Please consider to merge the bpf hepler functions
to one file. We have already xfrm_interface_bpf.c
and now you introduce xfrm_state_bpf.c.

Try to merge this into a single xfrm_bpf.c file.

