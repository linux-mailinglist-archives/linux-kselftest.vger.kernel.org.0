Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 056D2DFC5B
	for <lists+linux-kselftest@lfdr.de>; Tue, 22 Oct 2019 05:55:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387494AbfJVDzd (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 21 Oct 2019 23:55:33 -0400
Received: from mx0a-0016f401.pphosted.com ([67.231.148.174]:2962 "EHLO
        mx0b-0016f401.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1730979AbfJVDzd (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 21 Oct 2019 23:55:33 -0400
Received: from pps.filterd (m0045849.ppops.net [127.0.0.1])
        by mx0a-0016f401.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id x9M3tVuP006627;
        Mon, 21 Oct 2019 20:55:31 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=from : to : cc :
 subject : date : message-id : content-type : content-transfer-encoding :
 mime-version; s=pfpt0818; bh=PGWfnSty5387zpUABDgfiTyHw/zqbIjXSdDyABc4y30=;
 b=K5m+wAi9WofzGfMqfRvzM58gbA7uwVH8FhL55ZOllF8v5R9wzhfZ8RIUSpMDFVWo9JU0
 b4KvGj/ViFabXeM1AZbGKKl/WwXmIEsZH/k6QqSjo9DkBjMCdVHhNoAx0/Ztvg93ze2s
 yiNFPx7gOk+FcJXg42glymqhfZqEcJB9dPW+mt171Ivv6ZPqMPC+3NkPC46trLlgnAi+
 T0jeOeNVmj2dOM5cuynUV3k+yi2R7GkqdBQAxfc+ltp1qpTgjnCeMVbUAHtUgJXg5qOd
 Us0yFHfcfdsite92IwRM+5Uw3IV5Ntysee2yfo0788RKggzWQbjfD5odFxrNVWdU/mjW DQ== 
Received: from sc-exch04.marvell.com ([199.233.58.184])
        by mx0a-0016f401.pphosted.com with ESMTP id 2vqyuqj1vd-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Mon, 21 Oct 2019 20:55:31 -0700
Received: from SC-EXCH04.marvell.com (10.93.176.84) by SC-EXCH04.marvell.com
 (10.93.176.84) with Microsoft SMTP Server (TLS) id 15.0.1367.3; Mon, 21 Oct
 2019 20:55:27 -0700
Received: from NAM02-BL2-obe.outbound.protection.outlook.com (104.47.38.55) by
 SC-EXCH04.marvell.com (10.93.176.84) with Microsoft SMTP Server (TLS) id
 15.0.1367.3 via Frontend Transport; Mon, 21 Oct 2019 20:55:27 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lJVJHHeRRN07foxEUPCaQOKZ26Fb6aZLjnzrGwcFF5WaMtkSRwqBDyLpMGnN5DN6D+PLnMFxiBn0o4uUEykjc0yj+yYuJIqTpEHwdQ9FfonFzAs0JqP8iXumIIlwvYRrPijbgdSmSVkrrYqTuyXhg04qkQEjpcWK4SR2T1PifDWwJuaWXFf+wh3c3ChEWggTthXf3hcuvH6e/GNvdWI4heeGPKF0+KiDHSVUrrqLKdaT99pqgnp8l0++8Z4yuaQ4HmIdDb14YxIto91Kz3lkG9fAn10359QNcoZa+RlgENGs5BGtU7Pdkz5CSmNFg+uz0/ui8KKDESFQRQgdWZEtRQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PGWfnSty5387zpUABDgfiTyHw/zqbIjXSdDyABc4y30=;
 b=APqh6767gxsay16tnqGJPhHF+WKggoQ4TIoI1QQA6U3KmFQr03P8x1jEoGwYHR374GrqoeaRPpRiB91L5BfnJYrrkr8srxx0qtT2fitOZprnyk7GWuLTtXtcAmCayChux/JTpnaH7ePR5DkJz4e5+b7F+Q0DZBF64XdKCA77XOksEtgNIxjX00DaM5zatwkjI7U/I5eQyYbglqN+oN8nVJQTaSfvBOlT0NYEw94rLHir6x4oLLFcNNDy++7WqZ4P3Y7kbAyVwVAyH50HxPhvZtXGMql/pCYVN9QFzzOAqaY7YyEvvOHI9cRv6tCTzxAejrzYCni+Qi+92o1jtv2lZQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=marvell.com; dmarc=pass action=none header.from=marvell.com;
 dkim=pass header.d=marvell.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=marvell.onmicrosoft.com; s=selector2-marvell-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PGWfnSty5387zpUABDgfiTyHw/zqbIjXSdDyABc4y30=;
 b=Ll6qacmJqtogd5A2LzKtJyk/DKto35vriAf5gb2bt9tSqLgt2nriygNP74JUNx2X9CHUTpjOaQ0saA6muRKTRPlaJ9MV9+larNtb1Py0pt53pWNTKy5IuoVmiGN6eDDVgPkq9qQs5G3Qk/MyXMrvtBwKNPqZnf/FgQ6PHzIruK4=
Received: from MN2PR18MB2989.namprd18.prod.outlook.com (20.179.23.97) by
 MN2PR18MB2878.namprd18.prod.outlook.com (20.179.22.17) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2347.17; Tue, 22 Oct 2019 03:55:25 +0000
Received: from MN2PR18MB2989.namprd18.prod.outlook.com
 ([fe80::20e2:230e:2d69:be1f]) by MN2PR18MB2989.namprd18.prod.outlook.com
 ([fe80::20e2:230e:2d69:be1f%5]) with mapi id 15.20.2367.022; Tue, 22 Oct 2019
 03:55:25 +0000
From:   Prabhakar Kushwaha <pkushwaha@marvell.com>
To:     "linux-kselftest@vger.kernel.org" <linux-kselftest@vger.kernel.org>
CC:     "skhan@linuxfoundation.org" <skhan@linuxfoundation.org>,
        "Prabhakar Kushwaha" <pkushwaha@marvell.com>
Subject: [PATCH][v2] kselftest: Fix NULL INSTALL_PATH for TARGETS runlist
Thread-Topic: [PATCH][v2] kselftest: Fix NULL INSTALL_PATH for TARGETS runlist
Thread-Index: AQHViIyJ44HpPP7V5UuNerpmjF1wUA==
Date:   Tue, 22 Oct 2019 03:55:25 +0000
Message-ID: <1571716518-28574-1-git-send-email-pkushwaha@marvell.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: BYAPR05CA0089.namprd05.prod.outlook.com
 (2603:10b6:a03:e0::30) To MN2PR18MB2989.namprd18.prod.outlook.com
 (2603:10b6:208:a5::33)
x-ms-exchange-messagesentrepresentingtype: 1
x-mailer: git-send-email 1.8.3.1
x-originating-ip: [199.233.59.128]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: d8697674-861c-402b-79f0-08d756a3ab98
x-ms-traffictypediagnostic: MN2PR18MB2878:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MN2PR18MB2878B493D8F61981C2D5C72EB2680@MN2PR18MB2878.namprd18.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:541;
x-forefront-prvs: 01986AE76B
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(396003)(39860400002)(376002)(346002)(136003)(366004)(189003)(199004)(6436002)(5660300002)(8676002)(478600001)(102836004)(36756003)(6486002)(316002)(256004)(14444005)(6916009)(66066001)(81166006)(6512007)(81156014)(2501003)(5640700003)(2906002)(99286004)(6116002)(4326008)(3846002)(52116002)(71190400001)(8936002)(86362001)(66446008)(25786009)(107886003)(305945005)(66946007)(54906003)(71200400001)(2351001)(14454004)(476003)(2616005)(386003)(64756008)(4720700003)(486006)(186003)(26005)(7736002)(50226002)(66476007)(66556008)(6506007);DIR:OUT;SFP:1101;SCL:1;SRVR:MN2PR18MB2878;H:MN2PR18MB2989.namprd18.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: marvell.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: gRVK7GXl4bgagtnAfgmRULPwV9aoLfh7ClVjKBsb1KCp2DxcKQYEiBMPlnYeiQB7AmFibj9ryoOvLomfKvDV/0nKhk7N4Cv4KWLEgF/IELEb2myv2qCe7eTd5xvfzWZshkA+BZiofs7F4IXlrxU5th40UZrPgcX81shxqLxCUUGgKltCL4iAhE3anPgyQx/zfyo9vsIjl2MZcXnp6Jkjo4W1oyKGOMrM4BpfZjyzgGHdM/qRGpvh/H3XbeyYxWJFT9pml0BftwmUrS3H5/cSwr8KURfiJ+8WkrJ/MhiJgy1CeANBnroglxpYYRiqF/nSmDfpkuxI6p1ohz0540A6IZSE6hj1RrIf0ZZJBstgG08vmpI+wqlU7SoQScbS4cYWPZCNsJNb+r+pr+DXz3vb6J4/6yWgM7smQyRoqU42GzYoaIC/5V4GDQ+XBoXnRv0O
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: d8697674-861c-402b-79f0-08d756a3ab98
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Oct 2019 03:55:25.6797
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 70e1fb47-1155-421d-87fc-2e58f638b6e0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: omawHAutsUihVPCZREFvUu4N2UElJLvlU7v8dQ8240kOeooHt4HgUegX7ARJjb9fC13hUY7BNkrLvXKspwA1Rw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR18MB2878
X-OriginatorOrg: marvell.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.95,1.0.8
 definitions=2019-10-22_01:2019-10-21,2019-10-22 signatures=0
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

As per commit 131b30c94fbc ("kselftest: exclude failed TARGETS from
runlist") failed targets were excluded from the runlist. But value
$$INSTALL_PATH is always NULL. It should be $INSTALL_PATH instead
$$INSTALL_PATH.

So, fix Makefile to use $INSTALL_PATH.

Signed-off-by: Prabhakar Kushwaha <pkushwaha@marvell.com>
Reviewed-by: Cristian Marussi <cristian.marussi@arm.com>
---
Changes for v2: Fix Author mail id


 tools/testing/selftests/Makefile | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/testing/selftests/Makefile b/tools/testing/selftests/Mak=
efile
index 4cdbae6f4e61..612f6757015d 100644
--- a/tools/testing/selftests/Makefile
+++ b/tools/testing/selftests/Makefile
@@ -213,7 +213,7 @@ ifdef INSTALL_PATH
 	@# included in the generated runlist.
 	for TARGET in $(TARGETS); do \
 		BUILD_TARGET=3D$$BUILD/$$TARGET;	\
-		[ ! -d $$INSTALL_PATH/$$TARGET ] && echo "Skipping non-existent dir: $$T=
ARGET" && continue; \
+		[ ! -d $(INSTALL_PATH)/$$TARGET ] && echo "Skipping non-existent dir: $$=
TARGET" && continue; \
 		echo "[ -w /dev/kmsg ] && echo \"kselftest: Running tests in $$TARGET\" =
>> /dev/kmsg" >> $(ALL_SCRIPT); \
 		echo "cd $$TARGET" >> $(ALL_SCRIPT); \
 		echo -n "run_many" >> $(ALL_SCRIPT); \
--=20
2.17.0

