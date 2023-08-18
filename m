Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 71354780717
	for <lists+linux-kselftest@lfdr.de>; Fri, 18 Aug 2023 10:24:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1358563AbjHRIYU (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 18 Aug 2023 04:24:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53232 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1358570AbjHRIYK (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 18 Aug 2023 04:24:10 -0400
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2062.outbound.protection.outlook.com [40.107.21.62])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EF1882684;
        Fri, 18 Aug 2023 01:24:08 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GYL1WGuxH0Lb19V5k1DxOYD2IVP1e+4RuxhGfI4zgXwkomcyC3n+oA786ih9W4dSLG6pOxu65NZWAbtKDj6aArEGu92vNKl8B0U0WK5Csh24PkCMah+gwB7BgBECbbP2hC+vsclL0szJmYdSI/6h4jaE2yJYO9aOLcpljsn4/OF5y6YnS3HYJv+VA/W030C5JmVHlMx1nZIaZHBl/Q+WX3Z7JEStE8hIQvcmZsG2mfmkXfRw1B/+LZVKuIDMqA694lit6Av6KPZj6SuGqL6rYmkM9NQTPrl1mTZfYwra8U/QG7JKrR85IgA++Xwq8rgWfNIy6DlK7p+32JKVq5yuKQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4Z1kfcHfsl9pDKjodBJhzSflexASLIhFrTJ80RjzUF8=;
 b=BR7BBdUFtURu+iOy8JPOQxIOo53bqbutvd/Px8YmWsbH19ouQtp55w2H9xgCKe65QyV8l4LgLIhNU6GD/99MnNDJ/x5SO7qTaqUIDW1C1EY7QKqvkyAeaY+InELzF4LNrT3AXILHorEGto+aZ8at59pUjI1+nqDQR0S21+NHmpkdK6kuta8i96JcyBRbTGSVGKhkOjQu3tQgVNY+XuXviQJoMxpkKwG7BppXBlPSosrVDKs7aBdtpw8bRha27wKWPaFoN4cdNY+0XkmZkh+1V/JcscnLR3+iIpPNdj1v4LL4EngZ6ud4iu8CtfzWKOnq1Aa1wjdL432eCSiUfzhvgg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4Z1kfcHfsl9pDKjodBJhzSflexASLIhFrTJ80RjzUF8=;
 b=wzLlBU4sYZ5XsYLbyKH0vJHsCn3/G9KEf97ZTb7Uh61bXeJUu76q8B0DZqBmdFDy+oJny1C/FifMPtgPuW/oOSsa+A0RAMg8AwnNNy/B/ZsdDFJVpSJldZfRyiIXh2RIjQrok1OXHMFYrOlDGLiInuFUANz1sWI5NlDfbaE4u/uU6U9hPs4T8liLVUsL+3gRNn0dw68WzlftCLX/fovV/3j/VLhad5NAVL0959tvTBc6rXmE9FjMFmYxaHtfuRjVvq+IZI9yU9lCSTPZolhyVFCEh1AzJFp82ifMWLc1wWqsT1lmjm+qhTfPzIddzRQNyJktieCnHAqPZbWPtvYe8w==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by AM9PR04MB8890.eurprd04.prod.outlook.com (2603:10a6:20b:409::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6678.31; Fri, 18 Aug
 2023 08:24:06 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::2867:7a72:20ac:5f71]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::2867:7a72:20ac:5f71%3]) with mapi id 15.20.6678.031; Fri, 18 Aug 2023
 08:24:05 +0000
Date:   Fri, 18 Aug 2023 16:24:17 +0800
From:   Geliang Tang <geliang.tang@suse.com>
To:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Martin KaFai Lau <martin.lau@linux.dev>,
        Song Liu <song@kernel.org>, Yonghong Song <yhs@fb.com>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@kernel.org>,
        Stanislav Fomichev <sdf@google.com>,
        Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>,
        Florent Revest <revest@chromium.org>,
        Brendan Jackman <jackmanb@chromium.org>,
        Matthieu Baerts <matthieu.baerts@tessares.net>,
        Mat Martineau <martineau@kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        John Johansen <john.johansen@canonical.com>,
        Paul Moore <paul@paul-moore.com>,
        James Morris <jmorris@namei.org>,
        "Serge E. Hallyn" <serge@hallyn.com>,
        Stephen Smalley <stephen.smalley.work@gmail.com>,
        Eric Paris <eparis@parisplace.org>,
        Mykola Lysenko <mykolal@fb.com>, Shuah Khan <shuah@kernel.org>,
        Simon Horman <horms@kernel.org>
Cc:     bpf@vger.kernel.org, netdev@vger.kernel.org, mptcp@lists.linux.dev,
        linux-security-module@vger.kernel.org, selinux@vger.kernel.org,
        linux-kselftest@vger.kernel.org
Subject: Re: [PATCH bpf-next v14 1/4] bpf: Add update_socket_protocol hook
Message-ID: <20230818082417.GA20274@bogon>
References: <cover.1692147782.git.geliang.tang@suse.com>
 <ac84be00f97072a46f8a72b4e2be46cbb7fa5053.1692147782.git.geliang.tang@suse.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ac84be00f97072a46f8a72b4e2be46cbb7fa5053.1692147782.git.geliang.tang@suse.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-ClientProxiedBy: TYBP286CA0024.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:404:ce::36) To HE1PR0402MB3497.eurprd04.prod.outlook.com
 (2603:10a6:7:83::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: HE1PR0402MB3497:EE_|AM9PR04MB8890:EE_
X-MS-Office365-Filtering-Correlation-Id: 0de9fdc2-5c61-49ec-2e50-08db9fc47c30
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: aDRgNkK27Lgyk4ExRse4h0XTlZpvQ5scRoFPmN1nDw4iQcq1MhDbjk0dC4Xa+GE7142csfLf9Xav4dA1X7zVYmTAMXjmKWQQYl6YDdnRT/EWRuDI910UOVKl2yta2gM9yDaWgdGhP1xux5Ljk1/SWcHgxIKM26oUhXZXg+DpWhvCsiz2GtO0u7ck/s5326YNzXQqcTv7iS3Ii7cgJEDAMfHMP4vkCbiQH/fzshEJvt/U5oe2o/3Qgb+YTTTPqZiU8K5t5917sy0fYrLDEr6zskPfSKyM4SznyhXf6u/dmtvkbvME+WRYfyq9pVkoMm7c7fkHas3YVDef1ExFn8Z8GH8mCUi3J3sqeAxVAuXy8HnsQqte+pGepeqg5UTzN0hgg+n+3wD6UsyiAdygVzMAhfiSd2A6aM4+otGBHNaHhrGWPMbpcczW+z8ZM87vcehnttSF1Ex7PMVRYkVS1OnHe28I5VGAuHD/S1wenggW2XpCw5reTbQqJ1zSRRsfxlWS5Oy9vDmjp+QlHF/U+WBF17myUX1KVBdhxlX5r4X5/QEzf2drl+nr7hG2zH0fXzSqZuNSYg4yagx8SfNJUQqhZMxAPsYt1QV37cMsI7N8CvsCiDZpfYCim/V9kf8iaYzf
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7916004)(396003)(39860400002)(346002)(376002)(366004)(136003)(1800799009)(451199024)(186009)(83380400001)(66476007)(38100700002)(316002)(66946007)(66556008)(478600001)(110136005)(966005)(921005)(7416002)(7406005)(15650500001)(44832011)(2906002)(41300700001)(8936002)(8676002)(4326008)(5660300002)(1076003)(6512007)(9686003)(6506007)(6666004)(6486002)(26005)(86362001)(33656002)(33716001)(13296009);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?3vxWO0wADChU6ryT6nGXlR0P97DhmsecAfnDLBzrRJnePPr7/4TAB8tUdtmC?=
 =?us-ascii?Q?5qPVUE6v9iE+9v3MrqLgiD0gOJmvTqSSkf3vFUg45awJCuVkUE3/hTEHdW24?=
 =?us-ascii?Q?mqKTBPnNS1/sk6OgNa24tb34rdhZEkuB3vOLApx/G7Xzxvf+Nv8pYcgxtZ74?=
 =?us-ascii?Q?JpP11Go2Ed/QZLdiqF5BZ+AE4ckBvVEijRwbDxUDMt7FDEcBPhJnoScrj+HW?=
 =?us-ascii?Q?MdhIcFZL6dzfCPnkG0TJsS2jL7zK2pVKyCQiAo2Fa7laD3bs9YQUYWgi0DJp?=
 =?us-ascii?Q?8UYVwW2WARxmsXrzWFvP6aP8wekXxOdCHeOEA4Wpst4XTN95GATRCMnQ2xqV?=
 =?us-ascii?Q?SMmpcbwCaBAcObmwS5ogWO57DDTHMAVrsc78egZBPrrmhr8frjvLkR09tg9P?=
 =?us-ascii?Q?hSlu3FADfhSS2EftlA0SnfjY1qQFpDC5Z6VcvXmcYFfsinrwfBRZt+yv0kI5?=
 =?us-ascii?Q?QNkK1kXTmke4q4VX4yfZ1nepGuD5uGbRFmlkgV2KzG7A+JzCB3OfHhcG2zMI?=
 =?us-ascii?Q?NnVSbvZ6LmM/dkllLrI50kTDf1hqBZwXhc4bGpchtDVHn5vPRolqv0D6laUW?=
 =?us-ascii?Q?hHjjx+Ydwb5LLi6saRue9ge90ExZPJETV/dINeDH/pkWi1StifYDYci0svLu?=
 =?us-ascii?Q?J1ryz5Ub9kht5uNVjo+Nckx9AN0DFNaEIBAXux8ForyvmdgGS0WYQcEAY7ly?=
 =?us-ascii?Q?fc2Z3q50knU5QMcl5b34aEIWOs37zZbOPaSw3bSHeT/xGSJ72RRDM/K7kYqZ?=
 =?us-ascii?Q?ORXSZJL56+fxdqN10tTFS7YGIBXvI6s9Q1b9nekxn0bswNbJUtf6JOHubu/H?=
 =?us-ascii?Q?QGDQ6BJyiuzO0nHu3IdQi+I1tNQPl896RTeAwWbuSYO1c8Z+ww3qWlZ/dU0G?=
 =?us-ascii?Q?tLr5tM3kaPjifwwTsGuj9T94Aq8olhZS+2b1qMqSdITfhulVmTErtaI3zBXw?=
 =?us-ascii?Q?c8GWbdjdZHSuivPBCEUahCYnAh10fpcS+f1PONyQu7x3cQMnvv/YG+jfHHIR?=
 =?us-ascii?Q?wTXr6U/KXoF/GvAggclfzC0EQ6KLUe5I7xEIDG9oXkFNUJDTnvDk7xM6FyVN?=
 =?us-ascii?Q?eMvngquHJMt3aYIKtSwDV7YZEUpPVlpAeSpsJ9Iclr0f38l/n0QGISbvNt6b?=
 =?us-ascii?Q?7zPKb823KbNItf4Q68doOnZpgomqs/JbatoiFsqrMRp/5x1ccLjWzcn8OtdL?=
 =?us-ascii?Q?eLKvtueHVgBF/SvlSz6Qg2XPHvMO1HXhRSM7hmhTLGhZgXYBW74Nn5q2yRvg?=
 =?us-ascii?Q?W4XajyhkVed72eodMK2cJr5+MESALtVa/1GYWT6PDeKoBa9Vjogj14EbkkGy?=
 =?us-ascii?Q?zAzCDpo/qu21qmWWrUW7k5xV60ipricOllTQvI8uQwkBZRQyAd8UxmtByr9t?=
 =?us-ascii?Q?YbaDUU6wJmJ4U5SDlOeP22X6SUUnPkof95GPtzl8mFQ0cEOcHnjenwp6/JeZ?=
 =?us-ascii?Q?Uhv9tmk24RcQhZ8JMZspzvr/tmTmBSTEvCys2tNTtAq2Z13UY753E6h9AaC2?=
 =?us-ascii?Q?gIwj78h0PUvYe/DiufU60Ud+aAiFyumrOlr9AjymA2AMuGsdJJVVDvzXFaFq?=
 =?us-ascii?Q?qPOmTmb37l5+WMOX7Kr1Z5AXas4AIwXbT+JGvnSpZf7KdrHS3XzyyTTda6sV?=
 =?us-ascii?Q?4g=3D=3D?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0de9fdc2-5c61-49ec-2e50-08db9fc47c30
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Aug 2023 08:24:05.6248
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /7rGARtVbdDuoYYsH/Q3pQxaFnALvX4fWOHOIsT/z+C/O37nwlmdAqzqsNLMIGJFjFjzFQH5mk0Pj/l/xZylUg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR04MB8890
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Wed, Aug 16, 2023 at 09:11:56AM +0800, Geliang Tang wrote:
> Add a hook named update_socket_protocol in __sys_socket(), for bpf
> progs to attach to and update socket protocol. One user case is to
> force legacy TCP apps to create and use MPTCP sockets instead of
> TCP ones.
> 
> Define a fmod_ret set named bpf_mptcp_fmodret_ids, add the hook
> update_socket_protocol into this set, and register it in
> bpf_mptcp_kfunc_init().
> 
> Closes: https://github.com/multipath-tcp/mptcp_net-next/issues/79
> Acked-by: Matthieu Baerts <matthieu.baerts@tessares.net>
> Acked-by: Yonghong Song <yonghong.song@linux.dev>
> Signed-off-by: Geliang Tang <geliang.tang@suse.com>
> ---
>  net/mptcp/bpf.c | 15 +++++++++++++++
>  net/socket.c    | 26 +++++++++++++++++++++++++-
>  2 files changed, 40 insertions(+), 1 deletion(-)
> 
> diff --git a/net/mptcp/bpf.c b/net/mptcp/bpf.c
> index 5a0a84ad94af..8a16672b94e2 100644
> --- a/net/mptcp/bpf.c
> +++ b/net/mptcp/bpf.c
> @@ -19,3 +19,18 @@ struct mptcp_sock *bpf_mptcp_sock_from_subflow(struct sock *sk)
>  
>  	return NULL;
>  }
> +
> +BTF_SET8_START(bpf_mptcp_fmodret_ids)
> +BTF_ID_FLAGS(func, update_socket_protocol)
> +BTF_SET8_END(bpf_mptcp_fmodret_ids)
> +
> +static const struct btf_kfunc_id_set bpf_mptcp_fmodret_set = {
> +	.owner = THIS_MODULE,
> +	.set   = &bpf_mptcp_fmodret_ids,
> +};
> +
> +static int __init bpf_mptcp_kfunc_init(void)
> +{
> +	return register_btf_fmodret_id_set(&bpf_mptcp_fmodret_set);
> +}
> +late_initcall(bpf_mptcp_kfunc_init);
> diff --git a/net/socket.c b/net/socket.c
> index 5d4e37595e9a..fdb5233bf560 100644
> --- a/net/socket.c
> +++ b/net/socket.c
> @@ -1657,12 +1657,36 @@ struct file *__sys_socket_file(int family, int type, int protocol)
>  	return sock_alloc_file(sock, flags, NULL);
>  }
>  
> +/*	A hook for bpf progs to attach to and update socket protocol.
> + *
> + *	A static noinline declaration here could cause the compiler to
> + *	optimize away the function. A global noinline declaration will
> + *	keep the definition, but may optimize away the callsite.
> + *	Therefore, __weak is needed to ensure that the call is still
> + *	emitted, by telling the compiler that we don't know what the
> + *	function might eventually be.
> + *
> + *	__diag_* below are needed to dismiss the missing prototype warning.
> + */
> +
> +__diag_push();
> +__diag_ignore_all("-Wmissing-prototypes",
> +		  "A fmod_ret entry point for BPF programs");

Hi Martin & Yonghong,

I got a sparse warning for this new added 'update_socket_protocol':

 > touch net/socket.c && make C=1 net/socket.o

 net/socket.c:1676:21: warning: symbol 'update_socket_protocol' was not declared. Should it be static?

What should I do to fix it, or should I just leave it here? Please give
me some suggestions.

Thanks,
-Geliang

> +
> +__weak noinline int update_socket_protocol(int family, int type, int protocol)
> +{
> +	return protocol;
> +}
> +
> +__diag_pop();
> +
>  int __sys_socket(int family, int type, int protocol)
>  {
>  	struct socket *sock;
>  	int flags;
>  
> -	sock = __sys_socket_create(family, type, protocol);
> +	sock = __sys_socket_create(family, type,
> +				   update_socket_protocol(family, type, protocol));
>  	if (IS_ERR(sock))
>  		return PTR_ERR(sock);
>  
> -- 
> 2.35.3
> 
