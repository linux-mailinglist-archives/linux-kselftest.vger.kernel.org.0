Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 076C352E40B
	for <lists+linux-kselftest@lfdr.de>; Fri, 20 May 2022 06:51:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238899AbiETEvz (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 20 May 2022 00:51:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43982 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229523AbiETEvx (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 20 May 2022 00:51:53 -0400
X-Greylist: delayed 2024 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Thu, 19 May 2022 21:51:47 PDT
Received: from CHN02-SH0-obe.outbound.protection.partner.outlook.cn (mail-sh0chn02hn2243.outbound.protection.partner.outlook.cn [139.219.146.243])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D78A066697;
        Thu, 19 May 2022 21:51:47 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jQFhqoULCxTkYGhbnH0FLJb0walIdUn7Hpb8AXmWoGPgKKzz8VlqX3B2Q4T4VHhWBs9J+TcOKiPwVzWY8WBkoqLtv1Ia6Kbj9jxZisKLuyfapoFTLjIAJuothK4/MxsJpy6TzJBWsvuJkjZGR7Ts3CfA0CE2P1Aa6pZ+ZgU5amMnqYb9Q0wr0BeqEAcViXEITmR2BnPAFVAp5s2onMrzuvImXFld2sMxMmAgoz60QknHv4aECTYW9YpoKHJDJnDJmdE+joCiATqDnytXDIXJb9l+UPlVmXk3D7XeR9SP8/oo5hSiNu2zEbwebfqOoLvkZBogTjwTzLQTwnoKuHSKlQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XHa7Vpxtm/u3S4otqoZTmpXUuVJNGmaT4A6UJUMDuKo=;
 b=BdkDm2NxPKXNO/K9LkFlRJQdiYsGQQ+Gmi/qReVrIeCj28f9SJb7mMHSqDVjOkWR4vOVJce2ftYOw5Sf/wXnYn1+uKWr6mtelSYXBKpQuixWkmT+8hKPTKNn7UGnOlwKbJG3Bzi0ekebeIb+xnV7zy+j55DZuo+VwYKN6PP83ciDhHth9HbsqELlG8i5zxpBnqegSacliTvPBE4amGt584StdAFGc0LjWh97f/DLG7grgId3uBmel//NcqxABjvlylBJJx8S4dmn8/LFQuMGF2kbUGG1BjkS+vwLAwYl87NMaD9Wl1G9DYHmRs9jFvV0STEaDUt2YxlWzRrn8UWq1A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=gientech.com; dmarc=pass action=none header.from=gientech.com;
 dkim=pass header.d=gientech.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gientech.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XHa7Vpxtm/u3S4otqoZTmpXUuVJNGmaT4A6UJUMDuKo=;
 b=dk+qnXmOMcFCpNSbzzMlZOKMa1Q/laJLMOjS0PTVbnUoXnuKTTA3/A5t0NYFYeZCv8B/iDY805hpzYbdM8iHLMZjzywwAJcMH14phQqXj6D0R4Ia3hIGRcmL1vbxPMJLpx65nP+SjgCOL6jqjhP8P2RtX/mZLVGLhfYAHczDeJJj+W4uW7i9HEYDu54+ZIDc8Cq1biIw6i59h1WbIP18lRc96RY7y/Qm2KUa08iafHPXjXg+R5aIihp3b4LLxrLnlCnodD1f8P25c92hlMdtrtPah6w5QHPbLmFbmTy05MsCg7H6JCX5KHdb9zzd42682wZsjLx1UGqL3XzonAxFEw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=gientech.com;
Received: from SHXPR01MB0623.CHNPR01.prod.partner.outlook.cn (10.43.110.19) by
 SHXPR01MB0608.CHNPR01.prod.partner.outlook.cn (10.43.109.143) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5273.14; Fri, 20 May 2022 04:17:57 +0000
Received: from SHXPR01MB0623.CHNPR01.prod.partner.outlook.cn ([10.43.110.19])
 by SHXPR01MB0623.CHNPR01.prod.partner.outlook.cn ([10.43.110.19]) with mapi
 id 15.20.5273.017; Fri, 20 May 2022 04:17:57 +0000
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Content-Description: Mail message body
Subject: Ree
To:     Recipients <cuidong.liu@gientech.com>
From:   "J Wu" <cuidong.liu@gientech.com>
Date:   Wed, 18 May 2022 21:19:09 +0000
Reply-To: contact@jimmywu.online
X-ClientProxiedBy: BJSPR01CA0016.CHNPR01.prod.partner.outlook.cn
 (10.43.34.156) To SHXPR01MB0623.CHNPR01.prod.partner.outlook.cn
 (10.43.110.19)
Message-ID: <SHXPR01MB0623FE68F71397D099C52B6E89D19@SHXPR01MB0623.CHNPR01.prod.partner.outlook.cn>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: e467084f-1abb-4f58-8c8e-08da39141a10
X-MS-TrafficTypeDiagnostic: SHXPR01MB0608:EE_
X-Microsoft-Antispam-PRVS: <SHXPR01MB0608A2C041561ACEEE0B8CD289D39@SHXPR01MB0608.CHNPR01.prod.partner.outlook.cn>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: =?iso-8859-1?Q?Ue0irOpzG5TVWzJ8ssTlMzw7vm+w9/RnxSdT9M+ZtrCval/F1pVm+xn50M?=
 =?iso-8859-1?Q?tBOIRJ81f4a7Z1BWV/OlWpuKRtwJMcXdHkm/5DPQ6GDH0OuqenQdjnlU17?=
 =?iso-8859-1?Q?UJJ/+AmJyFq56Ud2PT255Iej7I+gqzUl+HI/8Q4+J/CgS8g/XtyaBXJQET?=
 =?iso-8859-1?Q?QKtiJOam82ct7F1ISSzXlxlwBiEft3KwpKtPrXyacP1wXAuWHZxcf/u4Vb?=
 =?iso-8859-1?Q?952zLHBzZsBG8O0/tXJLYmva7vqfa29jXUZFA+4oVumtpyg5oXzMLAJ5Zu?=
 =?iso-8859-1?Q?bIAdq4l7R6hAPizhnbDXnRBbOcs7KAzZvVhinhDGuoM7202QV6FU4B6rJm?=
 =?iso-8859-1?Q?eSIhOUUt6ZY9iD3XkJ7t0ETG7og19YYsSyzQ+Sj4KX9dM7EjAW54hToMeo?=
 =?iso-8859-1?Q?K2CtUJCmrZxz/EaZP+V9T6q+3K13Un4ozmA5wItm5n9eGSDq5byOuivwgQ?=
 =?iso-8859-1?Q?BUh2WMjViINmvYR9Iqsfs96UiAMrOqD2BiNcPlIbkF6bB6YKi46VlhutCU?=
 =?iso-8859-1?Q?OXE6ofPBqKZTv2DYWjFggEhTr5bYCjq21o6I7aIO/91OsptzjM2d1oSH32?=
 =?iso-8859-1?Q?s+MkjbfNTnMlkVOJBIn/e4VkQfhbeevp/bUztjBV6E+OG33MZG7RDYklpt?=
 =?iso-8859-1?Q?AIFm9IwUYuvH9EISA9MKKTpWiYP1UyECmTYM87zrx7AR2L6u1gYRo936pp?=
 =?iso-8859-1?Q?J6FItT20heWPM0zW2py4HUZgdHvUgeNyNxImmTEZVN+U4F40+oETS9qCYa?=
 =?iso-8859-1?Q?W0qfn0Mb0n1MUTS2t1MYbDdU6M8j9OTy/O8pj/mmAZwN+4QehQp6rq5rXx?=
 =?iso-8859-1?Q?rUanh8nTEZTOgD4Lctw/6HBga8DYMQZZm8GFx4myOTPxm2ez51Y4KKaVL4?=
 =?iso-8859-1?Q?UaSdiSEzoSFoCxxRi0OZ2WfPMYjtPjwWcgE66w+yz0ah/PWQ12cksmmT1A?=
 =?iso-8859-1?Q?P3koq/OCrJjb4MhZI49DnDI9/DDFWkjXVM46W17VL9EgyK/sQ8PpA3QioW?=
 =?iso-8859-1?Q?/b5/Ft3L0zBW4zrlnaVjdgqO96p4CG4L86DN9JVpKu3/RW5dNDo7fUD4P8?=
 =?iso-8859-1?Q?tA=3D=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:5;SRV:;IPV:NLI;SFV:SPM;H:SHXPR01MB0623.CHNPR01.prod.partner.outlook.cn;PTR:;CAT:OSPM;SFS:(13230001)(366004)(86362001)(186003)(33656002)(7116003)(38350700002)(38100700002)(508600001)(4270600006)(19618925003)(26005)(6200100001)(6666004)(7696005)(52116002)(9686003)(3480700007)(55016003)(40180700001)(40160700002)(8676002)(6862004)(7416002)(7406005)(7366002)(2906002)(558084003)(66476007)(66556008)(66946007)(8936002)(62346012);DIR:OUT;SFP:1501;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?iso-8859-1?Q?JqzOcIvSaqdOhyblxff9PoHtbsD8vcAJIQyDu9QnftdiU95ZRngMHZPBnN?=
 =?iso-8859-1?Q?ll2nex2NXPV1FQ7zNa7NsfJT2t2MbEmZ7RyZ/1l7D4CppVFXQGSmFEzSyr?=
 =?iso-8859-1?Q?4/0nVVNWPVSzeqhoz1K9cGRG+ol9xzEb8HPE3LbWC8tiOPxk7OSqTxIZyY?=
 =?iso-8859-1?Q?rX1L7PpnFXuD6Tz2KoPTpqA4GcB1q3ZRtJhDNgfP9PSczzP3QVinqyoVTL?=
 =?iso-8859-1?Q?6h9FF6VBqZZ/I/I5ypJ+MSHJhek8ighcRtwF6QgsULRgc6YxCVd72E4p5P?=
 =?iso-8859-1?Q?gT38MIScCSr48BBzfNEs2lH4pxYar5bjhFgpX4qMmVpEalf26SOxKKNUeS?=
 =?iso-8859-1?Q?RJ3oqtoIU8BoT+wefCoRRDGZhXTBGSMtgR3D3xlyRkzdkV9r6ZXNP7+DEY?=
 =?iso-8859-1?Q?8z6IcVsSEkrq7GN08LLgdPc5fgkz4EitdBZnZ/SjwWd1Y6K42PhOjYohSk?=
 =?iso-8859-1?Q?oy7euT3Kju64yRzIirqiGzhiji+w9ma+VDY+eJyTWPihk6VxwfxR0+nzxk?=
 =?iso-8859-1?Q?Ua8ln2/XWN/eFTnN/GWpn0B/AlWzilywHzV2V9gcZYqImJk3ttK4jJP0wv?=
 =?iso-8859-1?Q?tUJqRqlhwiR2BSsWNPf+TcO4WFvCrL3XJp2RHeUxH25atknPSwks/P3JqZ?=
 =?iso-8859-1?Q?YS8uGBrKaUQb6ZyLMnBU+B1WvOjpSlqfZd4AxT8K/Vx5EKcVUMnihtiIhF?=
 =?iso-8859-1?Q?XR2ecbVpLw0HTqnqbWsIpunKuKtMddWSX6FlQdKOzIlkw/lG84JafKEELJ?=
 =?iso-8859-1?Q?n87/PRg0dirLnjjGxWKOm5hCcbYRtLwdiQJ8ioVD3Pnd4+S8KPUXoTlLWG?=
 =?iso-8859-1?Q?ycTT1qkrTiwqKEZq0WoRMTtr6lexkQ5iJ1y287rv+3fOVCsy1GwMYsg5ek?=
 =?iso-8859-1?Q?6KsRTxDBlrqCt0seHOgWNrofyAB9VpY7teXvWmzou2Byo/G6K8r7LLcAou?=
 =?iso-8859-1?Q?63rqep47fRkkoiwV9UOzpFpq9dATfY5C13QB0w0SkcPPJk6UtINB9sh72W?=
 =?iso-8859-1?Q?zaX4qq9ieu7uOYtZczPTHEiw8bcM3/4lO1XjA0Hdgj7OMbxbPwZWGl7s62?=
 =?iso-8859-1?Q?kFevMkJSzBdw5IFD9mJxElHll0SGsL/nKlB4copD9tNPOgsZItr2AGMOdY?=
 =?iso-8859-1?Q?Z4IroN7L5BsNZ/bwKLYBQdj1C6Z+uBWmpL0ZLzaWQrfo3nkh0M3k+TLGWC?=
 =?iso-8859-1?Q?65dH9fCzzy5Ez5EW/+9txIbJbTuW6TGmq0J1sAhetpmFRK/owXyHLm6SQo?=
 =?iso-8859-1?Q?q/5Rblv+CHIboyZhvyF/nVxAYWcNrU93u3lXbrMMemBvq81F4EACWaeFrI?=
 =?iso-8859-1?Q?K/Z1Pjpi+3J/vHPJalRX88tp8q5K/+igopi7T9C8O+Wel3vnS6tSFZPJgs?=
 =?iso-8859-1?Q?S+vl0zGrdej1Wo3QpRBNPdOv2/3yEziDlgD+7S08Duman0dJPuf1J3VJQ8?=
 =?iso-8859-1?Q?/qtt6Y/USeJ+hmuprKvh24pD//wjrvUGSZlMfoAPbrcFE7JfG7gMM9WyF4?=
 =?iso-8859-1?Q?bysqoOfNOBIZwqgu3CdwY67ybhSlGhgJSLC3fILZMzXJjtWFs/hBvB/2Xm?=
 =?iso-8859-1?Q?Pk8VpietICIlQSFS0ff1jlwfXCpHHKY1NW65wWqV4ZupvJUDYtY8YGLTcV?=
 =?iso-8859-1?Q?KOHjfxlWUx7dgqF3x6W8WNWXOFFSEPYBpsL3frnF/5zizC9nlKPmIV/NWZ?=
 =?iso-8859-1?Q?uIuWq9WxL64m0Co1lzyjq63wbYDAl77nBNg27eY3s6lC2V0CPX6o27VFDh?=
 =?iso-8859-1?Q?+2mw=3D=3D?=
X-OriginatorOrg: gientech.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e467084f-1abb-4f58-8c8e-08da39141a10
X-MS-Exchange-CrossTenant-AuthSource: SHXPR01MB0623.CHNPR01.prod.partner.outlook.cn
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 May 2022 21:19:32.7017
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 89592e53-6f9d-4b93-82b1-9f8da689f1b4
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: dtlR2/OQE7vls9JRouvJcpBYEBLO2+MVgxbE3TRpDUkDzrWHgIKHQMRDz9t9qmZgZRnJCBKL0AUgHXNhvsfxuQTDj0luF8LTsSr9HpHEuz0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SHXPR01MB0608
X-Spam-Status: No, score=2.3 required=5.0 tests=BAYES_50,DATE_IN_PAST_24_48,
        DKIM_INVALID,DKIM_SIGNED,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Level: **
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Can you do a job with me?
