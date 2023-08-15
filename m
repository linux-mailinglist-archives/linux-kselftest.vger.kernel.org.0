Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 76E3777CAF3
	for <lists+linux-kselftest@lfdr.de>; Tue, 15 Aug 2023 12:08:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236352AbjHOKIT (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 15 Aug 2023 06:08:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48586 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236346AbjHOKIG (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 15 Aug 2023 06:08:06 -0400
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2052.outbound.protection.outlook.com [40.107.21.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 31468E65;
        Tue, 15 Aug 2023 03:08:03 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Qxny30uj47ZfScJurxZBnDlw9dwN8mXgZzNTPPi4pSntKoO8ZVdNkPJORTuwo81W0oqc91DSbPpm2gEr9d/FUOMkchp8wKURtfB25iCrxFevtqoBLTHdrm6WtWjPqCL/3LLmJ+fy42N6X9rgo2QDVhWp7l02aKavuM1aOiXN6JT5xMoNB/Lzt5jr9/rnPEX9OaRwOyVCJ0zvUhqCMaqFbzgg96UYh4HsYNpm3+7f0XzAYCPkeT5p0bwZHbeV+O+DyCo5VM3WzNXfrhyPrLnapcvYJH3pHJ6Bwl9raJmVK59S/NjnUqS/vxtyFOQ0v/5L038XNBXCoOocRmbJDpbuPQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VMOHZ/3ErHxlUPtp04s1cINgL/8IkCXNd8pGXxaSuVY=;
 b=der/Tro9hRcGR9hFMpMN6lxVNPP9KW+omeWiU+Offkiq5teGok7C4HnIqbSoIqB5XMNjPKmgREzp5bv5alXov0ztX/my96M4nlqoVZyGA6MqoRoV6sgm6/X6oJIORHCZsolqrgkkC95D42esrMc/b3ElPuF16LYuQAluQliD9b091cXqoG/ZIiLo/f7RKCJss1hD6AcREIclO1HJMHhxaNZ/o+bxAQ8ngBIOTMyIjGPClRtU8CCBUe6CIlvA2ehmMAXCyqml3O9gYGFUU01qWkRjkl0JEXg6BrRvMUngVOiCbwadqfkaiItRXL33ldUN4mg9Z3fMW4VAi0yGlhQKdA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VMOHZ/3ErHxlUPtp04s1cINgL/8IkCXNd8pGXxaSuVY=;
 b=mzmjxeawqOcwMa0U8+X/UkkSFlwsc7G1Jb7UC3gqcqG+kvlD1OjeQRMaiBNMj0PVwOjYOJ9VgSICwtv+ap1KlL7Bhzg4YCiMYW7XtdxpyzVBZpR1pau/3SFeSpT53oQ5/DWOU1dFlHL+mBIhgjMJQuqEg1eGoaaTZAtSs5OLCZZckMC5nMOBYlMjhfL1MXme/Cia+6U9YGkuRcYPo9kkar2pMd6AROcL2tduTcCRgq4nP5AzYnaBcJEzhSn8gq0BEPYWXbHgmOwsNbZrs73ig2SCdhm9W6o2ppkQl9XaISTJi8oQE0euLiMyzTrgnw96bvT6kECsi//mfWkF145S5A==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by AM9PR04MB8307.eurprd04.prod.outlook.com (2603:10a6:20b:3e6::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6678.26; Tue, 15 Aug
 2023 10:08:00 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::2867:7a72:20ac:5f71]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::2867:7a72:20ac:5f71%3]) with mapi id 15.20.6678.025; Tue, 15 Aug 2023
 10:07:59 +0000
Date:   Tue, 15 Aug 2023 18:08:16 +0800
From:   Geliang Tang <geliang.tang@suse.com>
To:     Martin KaFai Lau <martin.lau@linux.dev>
Cc:     Alexei Starovoitov <ast@kernel.org>,
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
        Simon Horman <horms@kernel.org>, bpf@vger.kernel.org,
        netdev@vger.kernel.org, mptcp@lists.linux.dev,
        linux-security-module@vger.kernel.org, selinux@vger.kernel.org,
        linux-kselftest@vger.kernel.org
Subject: Re: [PATCH mptcp-next v13 4/4] selftests/bpf: Add mptcpify test
Message-ID: <20230815100816.GA24858@bogon>
References: <cover.1691808484.git.geliang.tang@suse.com>
 <15a618b03f65177166adf2850d4159cd4b77dfb1.1691808484.git.geliang.tang@suse.com>
 <00809f4a-e7ca-bf53-7824-e22791ee6738@linux.dev>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <00809f4a-e7ca-bf53-7824-e22791ee6738@linux.dev>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-ClientProxiedBy: TYAPR03CA0018.apcprd03.prod.outlook.com
 (2603:1096:404:14::30) To HE1PR0402MB3497.eurprd04.prod.outlook.com
 (2603:10a6:7:83::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: HE1PR0402MB3497:EE_|AM9PR04MB8307:EE_
X-MS-Office365-Filtering-Correlation-Id: 38f714a3-7a39-4486-d151-08db9d7780c5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 13un73JGoua+TN/ee01SBnIcpHFGPpCLx+lOxRNJlyyQevTWM3QE1Cm6n/bMWBO2j2+EXDS4hjrHGPdOSCh4NZ86HmowF8n4JziVV+HM5Tau7Y3JEpa32HzvsOWMahsPaPiH4SDhngtINB51gLRhTtbTDdY7xqU1BsSCw/RtwJE97Th5MqyzXzW44cWqVe5EVJ7K0ZUG9H0ON+ry4HvVZUguCXAKuJK9ix0N4758XiBEwnXQtU77IHMqbtudziEeBdP1N+LiQzZXlhIlYBUwdbRAEWYCOTboc4sVrV4edpMHwfw4bUBjVWnkPD7tmSJr4VYliweKjPGqlnKkLbRFjAQgh5FWRHooe7lTLejvBUbp3e8U0n5WtQ+5upOEvAYETzTc4A5oYPkHnwdkGRhK0cRbCY+6k9amnTR6MnEnDvh643KSHYf7KOUzXPLRV9vmWq6a08cWDEX/7TUzPOt5XCNygwstgjBQ48cSF44nszbZmNRp5m5qPwJA3ZWXRc58baVfal/79bF8QMRDdotLTHRcdlXGlKmd6dDCsWMlUn11z8KrqFNT62mlzUh34McU+KZ9FTtsSkgeEKqtpvoyPfgsWkvDVv1S2QnxvWKMoX3j0nu8U5gJXuMUO/DRwdtQ
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(7916004)(346002)(366004)(396003)(376002)(39860400002)(136003)(186006)(1800799006)(451199021)(6486002)(6512007)(9686003)(6666004)(33656002)(86362001)(38100700002)(83380400001)(53546011)(6506007)(26005)(1076003)(44832011)(2906002)(54906003)(478600001)(33716001)(7416002)(41300700001)(66946007)(8936002)(66476007)(7406005)(8676002)(66556008)(5660300002)(6916009)(4326008)(316002)(13296009)(21314003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?Xbq1jS0Wbd2H2DLM7DWy5mnT2Y8EtaBnpT5UeSjjdNXUWb70yI/e5Mb9zsST?=
 =?us-ascii?Q?j0kqlx1b2wI4fMcb2KOvh+XTlz/j1ZlF30KcvYTBdmBJJ/EOOIFCQZG2fMlt?=
 =?us-ascii?Q?+nTt43BpKxxWLrpHG4ubQn0+C2QGm7DyzXukkDwaYA91oo8ow8jeg6UYoG65?=
 =?us-ascii?Q?pheif0O+ZiMKkQdhu6ra2011f/YIMBJqrfAj4g+GVahpJqMdSSnZLl9L5Ztn?=
 =?us-ascii?Q?zvFSDe0FDkLwcDIXKpTRTgWW8BfYp0XK8B4vzmV3EvFO798b45mzJr976qhC?=
 =?us-ascii?Q?EeqbWZbfHuah6ddaw31nwzatftrQfDWkPnDNsYwv0iJzXz8VkSE2wLhJbyzu?=
 =?us-ascii?Q?jqbHghfDEV6XW15VRdFAGVsMbPe5zz81V3V+P6eM85tAz4mspHzMAMHAALG0?=
 =?us-ascii?Q?AI3gzomoY4v7xGrmElaFdHTLQ476CTkOJAv0R0pEbBgMzJQD3iTQw4/GekBi?=
 =?us-ascii?Q?0xY3xwuz08trElPkNlhLK2gueZARX2QWBU7g6gRSRZWnbNL0MZxKsfHMHr3u?=
 =?us-ascii?Q?favLuNTnDHIt9v/mLY3y3xaItoKCXQL51HmZ/CWOOvhaut0okRC8D89HA3kE?=
 =?us-ascii?Q?qtvKrZeVJNTVkSfhgmW6GxkBR3p6oG5FuqxcCnVe81X1Ah+Qb2QfoevorgPd?=
 =?us-ascii?Q?MuSLbxbTOKW/j2ees8SMZTxLF1w9tSL1HZYbRMbshp6fNYe6ZcbGgofgV5Xu?=
 =?us-ascii?Q?avi+AvVA3zBzcyLAfLaoUxEOHamC56GGvxPCKgB+tFesVm4ylM5SLwPLlulZ?=
 =?us-ascii?Q?ywzkikF2HXq5QbZR3G3Y+n+zDW0Qx2hRgc4e+FdkWETCkAAAsZFIUdTZeWn+?=
 =?us-ascii?Q?QmmCe3dFVgwv8bBk2nWG3DN7mpZUEi0l2k4ayi/zmnr+G84e25IFyvkw08uW?=
 =?us-ascii?Q?9fTVlvhoPoAFooeZJloE+UNZw8pB+m4FX9dfBjBMKivipB/gH+mCuNKVRIhR?=
 =?us-ascii?Q?0NuB0Ek34APVY6RT6RUQI6lDCdrgTPtD+T1tLnwpH1DXpMBe+tXqBLjenaFZ?=
 =?us-ascii?Q?cLp8DS4hX0NnSZ67P16hn7SqGb3iY0bdjhoPzube3Sq28Ue6+fMYaYQ5iCOv?=
 =?us-ascii?Q?zmvX04TctIFzb5VKaKxgiElV4Uy3oPIVwiR4F7D/eHOAYMpW1ShK2YFDGQdW?=
 =?us-ascii?Q?olaFVsHSAprLDKacPZ74/zB/suNKN8FXtGdvyJrZnDdOSO4CfFqzN9ucpe3d?=
 =?us-ascii?Q?W5ySom1S6oYn+rrENf3/XMJVbxSN4lomwjYkfWTxZus5w0VG+6fDXVDDW4/M?=
 =?us-ascii?Q?yQaaSFynji1OY2oCRhd8eCvdFYbKtS4BciHG1Y6iqRnkZ0k12eBAr7GBdVIb?=
 =?us-ascii?Q?ltt0j+zFCXDISdGEUCqCepJ4jmxHVPn8esU9DlAdltEYyQsBGWDV0osGsciZ?=
 =?us-ascii?Q?Bu17Obu9bgJ22QDr1xmbInbntR5C7j/7bPfs4WTBbC5e5a1Fc5QrGRUBuQwl?=
 =?us-ascii?Q?Ty7dNa2RkEberXND8mzvb1q2r5EZTLMMvQ8vzk3v7FbvY02DXqp4F5zufBSw?=
 =?us-ascii?Q?/B+z2ZD3+ouWHkNgRrbmcXkLQcp3BJAgsTxoP87ES/tDUuYkBfcqOdhM/9uN?=
 =?us-ascii?Q?qcEZwojQ78xb8zyJbwlXUJ9Rxsk+ptJztGqdKvMn6mjaNEWIdPUY0m72Ml5C?=
 =?us-ascii?Q?EQ=3D=3D?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 38f714a3-7a39-4486-d151-08db9d7780c5
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Aug 2023 10:07:59.4714
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: nrtOYSC87Vb0M6KRJvACVGq6m+pZsABNVSsYPl6F75UsN4oaRLJwm1u/TzUEpdipMU3UReBu6gCKZkHGaJeTIA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR04MB8307
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Mon, Aug 14, 2023 at 11:23:49PM -0700, Martin KaFai Lau wrote:
> On 8/11/23 7:54 PM, Geliang Tang wrote:
> > +static int verify_mptcpify(int server_fd)
> > +{
> > +	socklen_t optlen;
> > +	char cmd[256];
> > +	int protocol;
> > +	int err = 0;
> > +
> > +	optlen = sizeof(protocol);
> > +	if (!ASSERT_OK(getsockopt(server_fd, SOL_SOCKET, SO_PROTOCOL, &protocol, &optlen),
> > +		       "getsockopt(SOL_PROTOCOL)"))
> > +		return -1;
> > +
> > +	if (!ASSERT_EQ(protocol, IPPROTO_MPTCP, "protocol isn't MPTCP"))
> > +		err++;
> > +
> > +	/* Output of nstat:
> > +	 *
> > +	 * #kernel
> > +	 * MPTcpExtMPCapableSYNACKRX       1                  0.0
> > +	 */
> > +	snprintf(cmd, sizeof(cmd),
> > +		 "ip netns exec %s nstat -asz %s | awk '%s' | grep -q '%s'",
> > +		 NS_TEST, "MPTcpExtMPCapableSYNACKRX",
> > +		 "NR==1 {next} {print $2}", "1");
> 
> Is the mp-capable something that the regular mptcp user want to learn from a
> fd also? Does it have a simpler way like to learn this, eg. getsockopt(fd,
> SOL_MPTCP, MPTCP_xxx), instead of parsing text output?

Thanks Martin. Yes, you're right. A better one is using getsockopt
(MPTCP_INFO) to get the mptcpi_flags, then test the FALLBACK bit to make
sure this MPTCP connection didn't fallback. This is, in other word, this
MPTCP connection has been established correctly. Something like this:

+       optlen = sizeof(info);
+       if (!ASSERT_OK(getsockopt(fd, SOL_MPTCP, MPTCP_INFO, &info, &optlen),
+                      "getsockopt(MPTCP_INFO)"))
+               return -1;
+
+       if (!ASSERT_FALSE(info.mptcpi_flags & MPTCP_INFO_FLAG_FALLBACK,
+                         "MPTCP fallback"))
+               err++;

It's necessary to add this further check after the MPTCP protocol check
using getsockopt(SOL_PROTOCOL). Since in some cases, the MPTCP protocol
check is not enough. Say, if we change TCP protocol into MPTCP using
"cgroup/sock_create", the hook of BPF_CGROUP_RUN_PROG_INET_SOCK in
inet_create(), this place is too late to change the protocol. Although
sk->sk_protocol is set to MPTCP correctly, and the MPTCP protocol check
using getsockopt(SOL_PROTOCOL) will pass. This MPTCP connection will
fallback to TCP connection. So this further check is needed.

-Geliang

> 
> > +	if (!ASSERT_OK(system(cmd), "No MPTcpExtMPCapableSYNACKRX found!"))
> 
> 
