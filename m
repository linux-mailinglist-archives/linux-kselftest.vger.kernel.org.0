Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id EA733BBF27
	for <lists+linux-kselftest@lfdr.de>; Tue, 24 Sep 2019 01:55:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2503556AbfIWXzH (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 23 Sep 2019 19:55:07 -0400
Received: from mail-eopbgr780110.outbound.protection.outlook.com ([40.107.78.110]:41037
        "EHLO NAM03-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729276AbfIWXzH (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 23 Sep 2019 19:55:07 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mp3+wwSdCzROrpV5FWVxhJ4NwZ50WRUz2vWipWpCkO8KB/wDEmCsEnVgX8gBOUNqby1dWn3cqKaq+3aw7SL128g1lvg+5uoCBFJ3UgT2DBhBiYjXwJ2Ho8I4S1a+ZsaadH3rWnM8uODtjHiKllc5Kfh83QqoEQy80GLFZxTvXG8NE8yrObMOY3QmgfoES5AinbsQJveUljGmt/lZnS0QO6WVVGLqBZuNrS6CGUGChFSMu+e4QvKXFiF3atANllLEmoYOGvXy0Fo2OpTkeHMOuyTZBfseV01Bp2OOh3zjjOWuDGeCWd4TuFs20nmXP5CtGu97GQ0D9hn2m7K1rGJrNA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ct4sLBzTx5uIOeVFb/HX49lvHcqgst5BEp4VuQUoLWw=;
 b=c/x8W8jSgGRPaFU+f4UfBQSs2Oe1a6ARdR/f26xWkNe23Oa2AZLDgH9KBqDio25kCYfbIuspKaWGNRnYDB03nzbwaGFnATtQ+oxVRtt9mXkwThMLgDavPYPGQLsGTZQuPYFGmAT9elVHEbCXJtoyg/KKttRFievEQQIyB6PjtenUiQixlc12pgrsJ+wSBYfgBrlIffaoku7tzS/GE9hpZx45KVZx3fkWo/1WBTa4ehYo2hJNikjvkFF3S5bh3YnLyG8s4NAaD2Gu3tu1zroQJ1VsuBtpwysWYCS55OgfshK2sYfK03cXtVsfAwcuZ1NGwtWxNYEyiGL6FauVnFoE0A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 160.33.194.230) smtp.rcpttodomain=kernel.org smtp.mailfrom=sony.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=sony.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Sony.onmicrosoft.com;
 s=selector2-Sony-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ct4sLBzTx5uIOeVFb/HX49lvHcqgst5BEp4VuQUoLWw=;
 b=eXoY9ymLDy3IDybdIBuOedjkoncp76q64+Gp5aur7F1Qa6aSMP6De7SXbqkfROjBPPduxJ7WuYvp8N1zlcRip3lNZ3PLtrXgHC8p1GF+If9CSbGj6Lzz8Mh30mQQJsvr50oHmmqVhdPNYFCn9hCzDH+DZnvNGQJM+C92McrCb6c=
Received: from BN6PR13CA0008.namprd13.prod.outlook.com (2603:10b6:404:10a::18)
 by BN6PR13MB1713.namprd13.prod.outlook.com (2603:10b6:404:14c::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2305.15; Mon, 23 Sep
 2019 23:55:01 +0000
Received: from BL2NAM02FT059.eop-nam02.prod.protection.outlook.com
 (2a01:111:f400:7e46::208) by BN6PR13CA0008.outlook.office365.com
 (2603:10b6:404:10a::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.20.2305.11 via Frontend
 Transport; Mon, 23 Sep 2019 23:55:01 +0000
Authentication-Results: spf=pass (sender IP is 160.33.194.230)
 smtp.mailfrom=sony.com; kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=pass action=none header.from=sony.com;
Received-SPF: Pass (protection.outlook.com: domain of sony.com designates
 160.33.194.230 as permitted sender) receiver=protection.outlook.com;
 client-ip=160.33.194.230; helo=usculsndmail03v.am.sony.com;
Received: from usculsndmail03v.am.sony.com (160.33.194.230) by
 BL2NAM02FT059.mail.protection.outlook.com (10.152.76.247) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.2284.25 via Frontend Transport; Mon, 23 Sep 2019 23:55:01 +0000
Received: from usculsndmail11v.am.sony.com (usculsndmail11v.am.sony.com [146.215.230.102])
        by usculsndmail03v.am.sony.com (Sentrion-MTA-4.3.2/Sentrion-MTA-4.3.2) with ESMTP id x8NNt09j004675;
        Mon, 23 Sep 2019 23:55:01 GMT
Received: from USCULXHUB06V.am.sony.com (hub.bc.in.sel.sony.com [146.215.231.44])
        by usculsndmail11v.am.sony.com (Sentrion-MTA-4.3.2/Sentrion-MTA-4.3.2) with ESMTP id x8NNsqbi020672;
        Mon, 23 Sep 2019 23:55:00 GMT
Received: from USCULXMSG01.am.sony.com ([fe80::b09d:6cb6:665e:d1b5]) by
 USCULXHUB06V.am.sony.com ([146.215.231.44]) with mapi id 14.03.0439.000; Mon,
 23 Sep 2019 19:54:54 -0400
From:   <Tim.Bird@sony.com>
To:     <mingo@kernel.org>, <torvalds@linux-foundation.org>
CC:     <brendanhiggins@google.com>, <skhan@linuxfoundation.org>,
        <broonie@kernel.org>, <jarkko.sakkinen@linux.intel.com>,
        <anders.roxell@linaro.org>, <linux-kselftest@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: RE: [GIT PULL] Kselftest update for Linux 5.4-rc1
Thread-Topic: [GIT PULL] Kselftest update for Linux 5.4-rc1
Thread-Index: AQHVb88gvPur7o2u00OFu0CYzZvRb6c0w2fbgABHV4CAAsmxgIACHd4Q
Date:   Mon, 23 Sep 2019 23:54:48 +0000
Message-ID: <ECADFF3FD767C149AD96A924E7EA6EAF977BB784@USCULXMSG01.am.sony.com>
References: <be8059f4-8e8f-cd18-0978-a9c861f6396b@linuxfoundation.org>
 <CAHk-=wgs+UoZWfHGENWSVBd57Z-Vp0Nqe68R6wkDb5zF+cfvDg@mail.gmail.com>
 <CAKRRn-edxk9Du70A27V=d3Na73fh=fVvGEVsQRGROrQm05YRrA@mail.gmail.com>
 <CAFd5g45ROPm-1SD5cD772gqESaP3D8RbBhSiJXZzbaA+2hFdHA@mail.gmail.com>
 <CAHk-=wgMuNLBhJR_nFHrpViHbz2ErQ-fJV6B9o0+wym+Wk+r0w@mail.gmail.com>
 <20190922112555.GB122003@gmail.com>
In-Reply-To: <20190922112555.GB122003@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [146.215.231.6]
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:160.33.194.230;IPV:NLI;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10019020)(136003)(376002)(346002)(396003)(39860400002)(13464003)(199004)(189003)(55846006)(37786003)(70206006)(70586007)(8676002)(47776003)(33656002)(106002)(316002)(8746002)(54906003)(5660300002)(110136005)(66066001)(4326008)(356004)(6666004)(15650500001)(6246003)(426003)(3846002)(6116002)(46406003)(53546011)(305945005)(102836004)(7696005)(8936002)(26005)(76176011)(97756001)(486006)(446003)(11346002)(476003)(55016002)(478600001)(246002)(50466002)(126002)(336012)(229853002)(2876002)(7736002)(186003)(23726003)(86362001)(14444005)(2906002)(5001870100001);DIR:OUT;SFP:1102;SCL:1;SRVR:BN6PR13MB1713;H:usculsndmail03v.am.sony.com;FPR:;SPF:Pass;LANG:en;PTR:mail03.sonyusa.com,mail.sonyusa.com;A:1;MX:1;
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: fd840736-a20d-4c93-adbb-08d7408172c0
X-MS-TrafficTypeDiagnostic: BN6PR13MB1713:
X-Microsoft-Antispam-PRVS: <BN6PR13MB1713D2953AAC325A27328DFEFD850@BN6PR13MB1713.namprd13.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-Forefront-PRVS: 0169092318
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: WvCQgXrqtNCzVqbjmy2Q4Nt5toxI33INh3+huiSRM9M9f/HZv/W17l55gv57Wh0Aq+2fl0th1B5EoIue2pSEfp0l0WVxQN1V4DumBbhlf80mBqrUpoj7SFGshDaT9jKCAz8R9Z3lDYSnebgx3FQJZ87Gs873Df0W1ia95JcvaDkMloniZs19CREaOEcxO8JyAKQoergQRxEpB73t+ElUpRYE7nlJOixW6em94ddM/MaF9w0HA2TuF5HWyR7lUcXKAxYwTpBUmMlLEe3TF7yveucSbE7INH7+LQejDH/ruh2+OX+UJrVL97lKvTnSDN8jGwCVwt0gYC+1S7+vdOyCQ9zxSt33pLcTjBbA+YEWKdc6pSbpgpQV7hNb4a5FBB3fXHz2zX1DVbLw4/aphh+6LghVbUypgD6ROfTayQgy88s=
X-OriginatorOrg: sony.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Sep 2019 23:55:01.6153
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: fd840736-a20d-4c93-adbb-08d7408172c0
X-MS-Exchange-CrossTenant-Id: 66c65d8a-9158-4521-a2d8-664963db48e4
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=66c65d8a-9158-4521-a2d8-664963db48e4;Ip=[160.33.194.230];Helo=[usculsndmail03v.am.sony.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR13MB1713
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

> -----Original Message-----
> From: Ingo Molnar on Sunday, September 22, 2019 1:26 AM
>=20
> * Linus Torvalds <torvalds@linux-foundation.org> wrote:
>=20
> > On Fri, Sep 20, 2019 at 9:35 AM Brendan Higgins
> > <brendanhiggins@google.com> wrote:
> > >
> > > Sorry about that. I am surprised that none of the other reviewers
> > > brought this up.
> >
> > I think I'm "special".
> >
> > There was some other similar change a few years ago, which I
> > absolutely hated because of how it broke autocomplete for me. Very few
> > other people seemed to react to it.
>=20
> FWIW, I am obsessively sensitive to autocomplete and overall source code
> file hieararchy and nomenclature details as well, so it's not just you.
>=20
> Beyond the muscle memory aspect, nonsensical naming and inanely flat file
> hierarchies annoy kernel developers and makes it harder for newbies to
> understand the kernel source as well.
>=20
> The less clutter, the more organization, the better - and there's very
> few valid technical reasons to add any new files or directories to the
> top level directory - we should probably *remove* quite a few.
>=20
> For example 'firmware/' was recently moved to drivers/firmware/, and in a
> similar fashion about a third of the remaining 22 directories should
> probably be moved too:
>=20
>   drwxr-xr-x    arch
>   drwxr-xr-x    block
>   drwxr-xr-x    certs           # move to build/certs/ dir
>   drwxr-xr-x    crypto          # move to kernel/crypto/ or security/cryp=
to/
>   drwxr-xr-x    Documentation
>   drwxr-xr-x    drivers
>   drwxr-xr-x    fs
>   drwxr-xr-x    include
>   drwxr-xr-x    init
>   drwxr-xr-x    ipc             # move to kernel/ipc/
>   drwxr-xr-x    kernel
>   drwxr-xr-x    lib
>   drwxr-xr-x    LICENSES
>   drwxr-xr-x    mm
>   drwxr-xr-x    net
>   drwxr-xr-x    samples         # move to Documentation/samples/
>   drwxr-xr-x    scripts         # move to build/scripts/

This one seems like it would break a lot of workflows, and contributor
muscle memory and scripts.  get_maintainer.pl and checkpatch.pl
are probably in quite a few people's scripts.

Also, I'm not sure '/build' is the right destination for this.  There
are a lot more things in there than just build scripts.  If you really
want to remove the top level 'scripts', it might be best to put
the  scripts from top-level '/scripts' into '/tools/scripts', which is
mostly empty now.
 -- Tim

... rest snipped ...
