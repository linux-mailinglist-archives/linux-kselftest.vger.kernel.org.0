Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D635D759771
	for <lists+linux-kselftest@lfdr.de>; Wed, 19 Jul 2023 15:54:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229736AbjGSNyq (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 19 Jul 2023 09:54:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36938 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229539AbjGSNyq (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 19 Jul 2023 09:54:46 -0400
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2048.outbound.protection.outlook.com [40.107.92.48])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F28D012C;
        Wed, 19 Jul 2023 06:54:44 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IgsFx/VCNBY6/32u6f89ove6yAvf1f/viZ9tIvKbvx1qqUYJmUyVHJIiniX1Wxo1/xka+V3Xeun7kI7WmL6OxhrlDMR66Lv0Sq31wz0ajqjUnQ1JS1dwRdLN55nBN8SpwR66jUcOCAaaozAjm02RsbhCcArl5e2s6YN9F3H3L0BmvFlx38UbYJ2Vw5PFN/HEZN2M1Pz/WTejGfc2aM/xFd709VAUYDMfuFs7ZtrRQTRUrJl8Revnuma5MMDX1qvGTWZSF1eYZKf+zYsxtlNvJvIqkitz/5vgCFqWAN17DXsANeJwFW+gw4WeowxepV2AqJdEHBNSdX7RIHnZ0mksJQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=o4laEa9hBnO7FSbSjdE1eon/nVyrJ5D1Yc/0g9elRkY=;
 b=QqO6bU/iR4LMgDPkSCozO19lvObhPohVF5iRUzqQO+ctjeIuASGcCGwhOUuc+tUAyd+baofwrHAeMvTolFmKaYbjVzGBaV6JJcuoCY1obpXVK9BrdFqbXjaRpqya68yVam85MBJGpYocRqSgoMVTaKu3JqOCcwOZ5BSo2EbUnzu6Gr/Y9fMe4hxNtQoN8BVmlo+dW11TPQxl/nHrvDDHAZ5yI/BU9vq4XZytZejAhD4vrHfHNRcm/jd4UYTZDpZVpg5tyLaZOPLtKi5HZ3SMKjdpNyBFY56C37YdICi8wcoZ4ZGX6hheLhykK+rabf2ccePR7cpnTn4dt1hN2AtpWA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=o4laEa9hBnO7FSbSjdE1eon/nVyrJ5D1Yc/0g9elRkY=;
 b=GpmUE2lYytUI693jUsx8OkfzoLujyawi9L09KCgmP3oEZZEw8mwZqWUIWwQs2DqTtJx1GVYzERpuSXtZfpRmCyjBnf47JZ4I96cnIFk5LgZ8moBYMxgCUBfIlz/SkhgSpIaS/WUPtetxWcCYDEjtGhxkZ1NUg60FN6/0ZT0PNh8Q9g5AEEu0b7+SreqvdcWJwOCT/hgK/f+MfCRMKGEVyvg/SMD9UX+apUq4qUdLLppRwvjPRLASNCN8yc7Cv25SaA3vnWK2AN5vLMFa1gReBfnAWYF4Wkl4v23TyeIdsGcHRAIh9+pFIBglYZ9X1c0jASdi6TJ/28h8YgeQ6KDZzQ==
Received: from MN2PR12MB4373.namprd12.prod.outlook.com (2603:10b6:208:261::8)
 by DS0PR12MB7746.namprd12.prod.outlook.com (2603:10b6:8:135::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6588.31; Wed, 19 Jul
 2023 13:54:41 +0000
Received: from MN2PR12MB4373.namprd12.prod.outlook.com
 ([fe80::982f:232b:f4af:29ec]) by MN2PR12MB4373.namprd12.prod.outlook.com
 ([fe80::982f:232b:f4af:29ec%5]) with mapi id 15.20.6609.022; Wed, 19 Jul 2023
 13:54:41 +0000
From:   Benjamin Poirier <bpoirier@nvidia.com>
To:     David Ahern <dsahern@kernel.org>
CC:     "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        Shuah Khan <shuah@kernel.org>,
        "linux-kselftest@vger.kernel.org" <linux-kselftest@vger.kernel.org>,
        Ido Schimmel <idosch@nvidia.com>
Subject: Re: [PATCH net-next 1/4] nexthop: Factor out hash threshold fdb
 nexthop selection
Thread-Topic: [PATCH net-next 1/4] nexthop: Factor out hash threshold fdb
 nexthop selection
Thread-Index: Adm6SJCO8cVTtOL88kWwn27DbVh5Dw==
Date:   Wed, 19 Jul 2023 13:54:40 +0000
Message-ID: <ZLfrG3Layt4fUmt8@d3>
References: <20230529201914.69828-1-bpoirier@nvidia.com>
 <20230529201914.69828-2-bpoirier@nvidia.com>
 <d030c097-ac93-eed4-5bdd-11f902b16fca@kernel.org>
In-Reply-To: <d030c097-ac93-eed4-5bdd-11f902b16fca@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: YQBPR01CA0122.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c01:1::22) To MN2PR12MB4373.namprd12.prod.outlook.com
 (2603:10b6:208:261::8)
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MN2PR12MB4373:EE_|DS0PR12MB7746:EE_
x-ms-office365-filtering-correlation-id: ad7c1b43-51c8-44ae-9994-08db885fb318
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: HcUKgkgIAlkgc/r5GPUAleo1vXbt1oKe7m69OVnD6t0BQwtnOuJbFNfXF7Wu1BXJoAQ3qpmSQzm1nt3Ce2Skl9BpLscVdOEJ26KTmaC4LlXZkbmtf7zmMv+BYFXJtvrGuvoFcejptLrAdqTqXAW4X8IARkJbq4sZYiVcCe83xBpoqLc5ioxP7f6DHgX1mnk7ypMWoOVHTxVvVEhSTyANQRPvwjBI5lZxwTSw/+wQ1iEvsSX6E+8S7x5rdyJ4ZnmEIKUWsNupzHs7wo9KWVGMitGwSTdBZS/0zk85CsEnBljVhKkP1LLkSnsKVC3rFlKbv0oUmVUQcPFult2uX5/9aVaAiFV2Dy+9+yWh1rRsatJ3vQQY9Yn4bPxTGB79xIAd/AVOc5RHQgKO1E5iqWDc/HHizs8bcYGYpjS+3SGAzUFNFu6kIQhwpxWt5MzFsY2cSNqNf2UHArdMwTHlV7b4F3MXYoU/0IgciCrjfXY2oE7aFZF8xmp5S90Cof1gqp1K+UDHkPUBcL0170rXSv1Z4wzbR7ebsLhKKfDHb5qmCer7hwH+ZjM43vQ1TFosurfF
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR12MB4373.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(7916004)(4636009)(366004)(136003)(396003)(39860400002)(376002)(346002)(451199021)(5660300002)(66556008)(66446008)(66476007)(66946007)(54906003)(64756008)(316002)(4326008)(6916009)(8936002)(2906002)(8676002)(41300700001)(71200400001)(66899021)(478600001)(6512007)(9686003)(53546011)(6486002)(107886003)(6506007)(26005)(38100700002)(186003)(122000001)(33716001)(86362001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?5BBLDgzO1Ar2M7JJK36PtPS72N3O3tMnM+IXX/3HiTWNuNX9d5V8Zo2KBHFz?=
 =?us-ascii?Q?UafhabWm1rsGDNzxtGNrg/tLOv5HP99036MET8BsbVqbkD7TJE8PrUxT3iWg?=
 =?us-ascii?Q?qUZDtJiYDtVuiAKcog3whmSgkqaA7Z7HCCx+qVcGw8pLg54+Dj3I6+tLpBu6?=
 =?us-ascii?Q?jvl32Bj6Iph6+9yGlMvxnG7MaEAq+PqAfWt67F8oB7qsoXXhTdlH8fkX/wBj?=
 =?us-ascii?Q?7FLPYHvsU/skAy250KkaIhcQYtobFazvxu/qQSXKLqystYcl43qGpVHJHmdQ?=
 =?us-ascii?Q?4saFclmw/ePkn5QBoYkUkB3uuR4mc3JIXbqev7wqgGavilV3cn9UbLxl7qej?=
 =?us-ascii?Q?/Zprh9GOjqGPZvGlYSxS4Ewj/IFzkl4AkpqTx8Tcs4+FMA4ec+Veo4a0se+r?=
 =?us-ascii?Q?EVJD+n5g7EsOUoYThSoXasGC7/pLOCjpHY6CdIEmOTtyJttMQ4z9jnvHYHrz?=
 =?us-ascii?Q?EzVAEWj0VzNCiHvAOdzd3Jz4zqlUhK6w/0qlJGlMekfIe4k3QrjiV5ASbKBF?=
 =?us-ascii?Q?NbXPt7H7I2RRTz98HXeSywVG3nSeLwlBydTegN2RLD6WpJ+8a72c6kV/OkzC?=
 =?us-ascii?Q?7kVjYWynz3fJfc2SZ2r6aDbhgZ3GvMb6Dc+biXqBqh8xdv+1hRwu87YLzJcy?=
 =?us-ascii?Q?A5wylrIkXbTw9HdaDxOybVFJj2suk4JVsgo9UO+EUbAJBag9ggqAR/EEOjhO?=
 =?us-ascii?Q?aDsM76UnEmKIS7UoYT1h4UeFifhJFbBX3AkMvU8qQa+pqKnwohPy5izrQh/Q?=
 =?us-ascii?Q?KX523dMoQ2rwg518C4AOp1H2bUrDRtsxVwpAcLn23n3iIkqmcNnNGUO/MmEO?=
 =?us-ascii?Q?yNu3qE7heeS1tX+R4SAXIMTFZLR7DIzQpDJkM5a07oTmCwug2k/Sz319yJ2F?=
 =?us-ascii?Q?uW895mjBf1CSbdV/EtZS7AZ/37Jkr6f9fQxY3nrVQ9iH2lLtwB3HQX1losx6?=
 =?us-ascii?Q?AjZ5woL7PMJRWci9F/48YXpZ7mzkoulANQpM1NVlFWkXV9z7jQSyniQgf4Li?=
 =?us-ascii?Q?WXOXQPWjxPdnb8qxlXy4FWbZ4ojmryt77deLzMleu0GIaD4QSOvhMyv2jp3p?=
 =?us-ascii?Q?YPUW29X0ncFSKWqaKv2ODXETDkPQYvb0rSpYrsdHXNvxKnD5Ylx60KZK+TPt?=
 =?us-ascii?Q?OzULzC3Ymq+mVk4c40+/WZc8v4PX3L26pe8s1RYcpo6+SzkKF8snwK/njDl0?=
 =?us-ascii?Q?M6WCEm1cNKgDhvtbzdrCaKCkB/kRdb7XddOWfOhR3dEb/Qogn7fwuNWbI9AU?=
 =?us-ascii?Q?rNgLjlAHNbKYWJbG8WjWkOEphsusYnOtFe6kZV0rRQ4MeDxos2YDyvfEeKIs?=
 =?us-ascii?Q?bMCGgkAvLA1bDtKAG2fHg6HLtlPwhq/wTxCVuJ9wqzpkSBPpar5Z4px2ldOi?=
 =?us-ascii?Q?jIxeCQLSjBYtSc8lBa1Lfcwb0DlLwl4DBo1iHRM3SIVRroFG2OXeR9jXvTCq?=
 =?us-ascii?Q?xO6PXIC9/dkToG2Vs+Nq1bcY82q2Orob1yOTRLQLmxx+q08mqxI4ZyF/jD1q?=
 =?us-ascii?Q?LQV0ATi5g4vRtWv5FNlyeR/P9aH0xhx6pM18r+LjZV8pA5EGSPpxL6Uu0+bP?=
 =?us-ascii?Q?wHddOpIgcER1QY2fjpJBsXUzgCG6n5jAnijQE/Lr?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <F699DD611AAD7E4BA45340F54E3E50E9@namprd12.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB4373.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ad7c1b43-51c8-44ae-9994-08db885fb318
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Jul 2023 13:54:41.0741
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 67xeL91rVs5JqmyL34izsZY/WGVFFA4XS/Ln0xqVUQO0fOsSz43/+F9o0lFsySqPd8ppHT7/rQDQ0u7RXC7PJA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB7746
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On 2023-05-30 08:57 -0600, David Ahern wrote:
> On 5/29/23 2:19 PM, Benjamin Poirier wrote:
> > diff --git a/net/ipv4/nexthop.c b/net/ipv4/nexthop.c
> > index f95142e56da0..27089dea0ed0 100644
> > --- a/net/ipv4/nexthop.c
> > +++ b/net/ipv4/nexthop.c
> > @@ -1152,11 +1152,31 @@ static bool ipv4_good_nh(const struct fib_nh *n=
h)
> >  	return !!(state & NUD_VALID);
> >  }
> > =20
> > +static struct nexthop *nexthop_select_path_fdb(struct nh_group *nhg, i=
nt hash)
> > +{
> > +	int i;
> > +
> > +	for (i =3D 0; i < nhg->num_nh; i++) {
> > +		struct nh_grp_entry *nhge =3D &nhg->nh_entries[i];
> > +
> > +		if (hash > atomic_read(&nhge->hthr.upper_bound))
> > +			continue;
> > +
> > +		return nhge->nh;
> > +	}
> > +
> > +	WARN_ON_ONCE(1);
>=20
> I do not see how the stack is going to provide useful information; it
> should always be vxlan_xmit ... nexthop_select_path_fdb, right?

Not always, it is also possible to have a resilient nhg with fdb
nexthops. In that case, nexthop_select_path_fdb() is not called. In
practice, I tried such a configuration and it does not work well. I have
prepared a fix that I'll send after the current series has been dealt
with.

Sorry for the long delay before my reply.
