Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 26E9E10D6D8
	for <lists+linux-kselftest@lfdr.de>; Fri, 29 Nov 2019 15:21:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726808AbfK2OVA (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 29 Nov 2019 09:21:00 -0500
Received: from mail-eopbgr50078.outbound.protection.outlook.com ([40.107.5.78]:54180
        "EHLO EUR03-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726608AbfK2OVA (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 29 Nov 2019 09:21:00 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YzPg5+ixRWs+bbPWBBFMJeqUxtjJgxKAmQQnfzvuVLTbcpF85micJkfx8icJ3VvhwBLncZyyJu5qlwTm3NJeBV+1EfzLIMb2q+G24ZOA++sEk0aTbEYlLzYcrGQCCTNoc8hzDXV/vzQwhvzSVwjBSuJyv7tZtIsIi85c5S+SdXxNy4++E7c3KmEmuI5KO+wGGeqjmpgzCBOz0MRZ/wmCw30ysGKyy9k7Cj8S12frvAMS544xsXpQhu+jU8o7u8EjBvnXP4dB3XNdCKX4SNv1W/dIINC0HggBaOAVlLQbG+x+ATh5GsbcNt+RXs1oEtaFGFPXJI2fA/y3Gzpa5FFSTg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dh7OQ2dRllBJEI8pvaJuUi14Q1CLC5OxzTr9oCkDu2o=;
 b=c7b6aMM/O/fdaUjDuwhS7O/KdAIypDWQiGw64VNVAfAIB0Gyl88ocBoa2GEaKwol5tJSQ5W6qgLHSeV2z3bG80ygy9hZwwX4DtCvWR2kyCirlT1Mr6qbZXG6igzcyWadfWaDLsahJagxr4qh6VEVNkb6WJTchslpu9JvAt08ZTVdDJWGMNRu2+ko6rZXXB+4y7hJqq4XpQdGlxo1MgpWfElfaWV+eVwD0H6POt9LWyNXwTxhAu9O/XUuvG+wdFZojpmAPkZsmwidFhZ/Mr4rhdmkUUSEzmoBsjTcSkAV31ZDyHb0Mjj9bKHfoDQrjrQVo8jFD/W6BeKv9e2Zi0kgdA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dh7OQ2dRllBJEI8pvaJuUi14Q1CLC5OxzTr9oCkDu2o=;
 b=AO3GneYDNIXXCdUPtcI5nj0yz0BNhQHR2OXlIvhlt+z4Rszo8xrFG0UBJoJ58zJKd16xR3+qd79Ff7j3e9hfT1ql/TxAdVzw0ukuaWDCwn6yxYdZbbEB5+5zKZFlWeCe0F/hVh6y6DOj6v1biT7Y9YXvSxUEt7xvHXUedRB9uSA=
Received: from VI1PR04MB7023.eurprd04.prod.outlook.com (10.186.159.144) by
 VI1PR04MB5328.eurprd04.prod.outlook.com (20.177.50.89) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2474.19; Fri, 29 Nov 2019 14:20:55 +0000
Received: from VI1PR04MB7023.eurprd04.prod.outlook.com
 ([fe80::dd0c:72dc:e462:16b3]) by VI1PR04MB7023.eurprd04.prod.outlook.com
 ([fe80::dd0c:72dc:e462:16b3%5]) with mapi id 15.20.2495.014; Fri, 29 Nov 2019
 14:20:55 +0000
From:   Leonard Crestez <leonard.crestez@nxp.com>
To:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        MyungJoo Ham <myungjoo.ham@samsung.com>,
        Kyungmin Park <kyungmin.park@samsung.com>
CC:     Matthias Kaehlcke <mka@chromium.org>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        =?iso-8859-2?Q?Artur_=A6wigo=F1?= <a.swigon@partner.samsung.com>,
        Angus Ainslie <angus@akkea.ca>,
        Brendan Higgins <brendanhiggins@google.com>,
        "linux-kselftest@vger.kernel.org" <linux-kselftest@vger.kernel.org>,
        "kunit-dev@googlegroups.com" <kunit-dev@googlegroups.com>,
        "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
        dl-linux-imx <linux-imx@nxp.com>
Subject: Re: [PATCH v4 0/4] PM / QoS: Restore DEV_PM_QOS_MIN/MAX_FREQUENCY
Thread-Topic: [PATCH v4 0/4] PM / QoS: Restore DEV_PM_QOS_MIN/MAX_FREQUENCY
Thread-Index: AQHVpGyZQVpBxfUGMEaAHkJwZ4bIpg==
Date:   Fri, 29 Nov 2019 14:20:55 +0000
Message-ID: <VI1PR04MB702392557AA56C0A49A463AAEE460@VI1PR04MB7023.eurprd04.prod.outlook.com>
References: <cover.1574781196.git.leonard.crestez@nxp.com>
 <3839981.6bSit4Rgby@kreacher>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=leonard.crestez@nxp.com; 
x-originating-ip: [92.121.36.198]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 9ba0e9d6-ddf8-4c5e-2ea4-08d774d758e3
x-ms-traffictypediagnostic: VI1PR04MB5328:|VI1PR04MB5328:
x-ms-exchange-purlcount: 6
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <VI1PR04MB5328EC9BBD088C1DF266B6EEEE460@VI1PR04MB5328.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-forefront-prvs: 0236114672
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(396003)(346002)(376002)(136003)(39860400002)(366004)(189003)(199004)(6436002)(4326008)(478600001)(52536014)(110136005)(55016002)(25786009)(966005)(6306002)(3846002)(9686003)(54906003)(5660300002)(6116002)(8676002)(81156014)(81166006)(6246003)(33656002)(99286004)(2906002)(8936002)(316002)(229853002)(45080400002)(26005)(186003)(7416002)(102836004)(14444005)(4001150100001)(256004)(53546011)(6506007)(7696005)(76176011)(66066001)(66946007)(86362001)(71190400001)(76116006)(305945005)(74316002)(71200400001)(7736002)(446003)(44832011)(64756008)(66446008)(66556008)(66476007)(91956017)(14454004);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR04MB5328;H:VI1PR04MB7023.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: M0YS2PfBuYWYdGsQbao2Q1SZKi800MnbLX1dtqvCZF+hCUcxd19l2YdOUneCAA/TnP98l2EdYQNL6Hvxf1bS/Kxd6vC9mymfEfEe8hQVocBeVPe7KGyOH/A1Urdh+c/V65fm1aGmAQs+7b+431R/wjTsdEhr5dORu4LHlS0iXnJTAPzo0NL28PUMRP8gpFPRo5r51qjL9C2HY/2PiDNVe7YLY+oxJwC17YfPwIGovQozC2fzxhV2LBCqaX7vl1ctML38dNSiSIpF6Yf24cS4UUUZEvRROIBvd7/8MUlSFHOAdupgjSqMoU+4kJCDkGS9lxHB06vMST2v7jpATVi5K0YYmKlSe/rDvuAlEH8ZLCd29HrY2r49iQu+ypjbeylOt2EoKWWVmZRGivQNSacbVcHgiF5+EXQp5+97CGxr0YQGSKE+wTRV8PHzAnK6sVVEvac6J7i8miYrMOKxo2e5JctNk4kSHgm3e7nJuExmdvQ=
Content-Type: text/plain; charset="iso-8859-2"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9ba0e9d6-ddf8-4c5e-2ea4-08d774d758e3
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Nov 2019 14:20:55.3173
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: IRmIEupl26Xdx1cUgmy7jWfvIdtCgARBfhyX57GP8udLLkz10h0yJMpP0ATc7HSl2fw+5p11qzzOs0tjkGdeDg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB5328
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On 2019-11-29 1:34 PM, Rafael J. Wysocki wrote:=0A=
> On Tuesday, November 26, 2019 4:17:09 PM CET Leonard Crestez wrote:=0A=
>> Support for frequency limits in dev_pm_qos was removed when cpufreq was=
=0A=
>> switched to freq_qos, this series attempts to restore it by=0A=
>> reimplementing on top of freq_qos.=0A=
>>=0A=
>> Discussion about removal is here:=0A=
>> https://eur01.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2Flore=
.kernel.org%2Flinux-pm%2FVI1PR04MB7023DF47D046AEADB4E051EBEE680%40VI1PR04MB=
7023.eurprd04.prod.outlook.com%2FT%2F%23u&amp;data=3D02%7C01%7Cleonard.cres=
tez%40nxp.com%7C4531c54354d54442d71808d774c02866%7C686ea1d3bc2b4c6fa92cd99c=
5c301635%7C0%7C0%7C637106240968746397&amp;sdata=3DLYIRtXYe8qPz1G%2F0ADYpPhb=
hviv1pkk7%2B%2BQ1dX1DQR8%3D&amp;reserved=3D0=0A=
>>=0A=
>> The cpufreq core switched away because it needs contraints at the level=
=0A=
>> of a "cpufreq_policy" which cover multiple cpus so dev_pm_qos coupling=
=0A=
>> to struct device was not useful. Cpufreq could only use dev_pm_qos by=0A=
>> implementing an additional layer of aggregation anyway.=0A=
>>=0A=
>> However in the devfreq subsystem scaling is always performed on a per-de=
vice=0A=
>> basis so dev_pm_qos is a very good match. Support for dev_pm_qos in devf=
req=0A=
>> core is here (latest version, no dependencies outside this series):=0A=
>>=0A=
>> 	https://eur01.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2Fpat=
chwork.kernel.org%2Fcover%2F11252409%2F&amp;data=3D02%7C01%7Cleonard.creste=
z%40nxp.com%7C4531c54354d54442d71808d774c02866%7C686ea1d3bc2b4c6fa92cd99c5c=
301635%7C0%7C0%7C637106240968746397&amp;sdata=3DYodRx0IRVsjQXYA5X7UEosn%2Fa=
tO%2BWREfotwWrley2DQ%3D&amp;reserved=3D0=0A=
>>=0A=
>> That series is RFC mostly because it needs these PM core patches.=0A=
>> Earlier versions got entangled in some locking cleanups but those are=0A=
>> not strictly necessary to get dev_pm_qos functionality.=0A=
>>=0A=
>> In theory if freq_qos is extended to handle conflicting min/max values t=
hen=0A=
>> this sharing would be valuable. Right now freq_qos just ties two unrelat=
ed=0A=
>> pm_qos aggregations for min and max freq.=0A=
>>=0A=
>> ---=0A=
>> This is implemented by embeding a freq_qos_request inside dev_pm_qos_req=
uest:=0A=
>> the data field was already an union in order to deal with flag requests.=
=0A=
>>=0A=
>> The internal freq_qos_apply is exported so that it can be called from=0A=
>> dev_pm_qos apply_constraints.=0A=
>>=0A=
>> The dev_pm_qos_constraints_destroy function has no obvious equivalent in=
=0A=
>> freq_qos and the whole approach of "removing requests" is somewhat dubio=
s:=0A=
>> request objects should be owned by consumers and the list of qos request=
s=0A=
>> will most likely be empty when the target device is deleted. Series foll=
ows=0A=
>> current pattern for dev_pm_qos.=0A=
>>=0A=
>> First two patches can be applied separately.=0A=
>>=0A=
>> Changes since v3:=0A=
>> * Fix s/QOS/QoS in patch 2 title=0A=
>> * Improves comments in kunit test=0A=
>> * Fix assertions after freq_qos_remove_request=0A=
>> * Remove (c) from NXP copyright header=0A=
>> * Wrap long lines in qos.c to be under 80 chars. This fixes checkpatch b=
ut the=0A=
>> rule is already broken by code in the files.=0A=
>> * Collect reviews=0A=
>> Link to v3: https://eur01.safelinks.protection.outlook.com/?url=3Dhttps%=
3A%2F%2Fpatchwork.kernel.org%2Fcover%2F11260627%2F&amp;data=3D02%7C01%7Cleo=
nard.crestez%40nxp.com%7C4531c54354d54442d71808d774c02866%7C686ea1d3bc2b4c6=
fa92cd99c5c301635%7C0%7C0%7C637106240968746397&amp;sdata=3De%2B5SGU%2Bx4Ujx=
lY292ejMO1kDewc3MmFvCpf0SDB0K4U%3D&amp;reserved=3D0=0A=
>>=0A=
>> Changes since v2:=0A=
>> * #define PM_QOS_MAX_FREQUENCY_DEFAULT_VALUE FREQ_QOS_MAX_DEFAULT_VALUE=
=0A=
>> * #define FREQ_QOS_MAX_DEFAULT_VALUE S32_MAX (in new patch)=0A=
>> * Add initial kunit test for freq_qos, validating the MAX_DEFAULT_VALUE =
found=0A=
>> by Matthias and another recent fix. Testing this should be easier!=0A=
>> Link to v2: https://eur01.safelinks.protection.outlook.com/?url=3Dhttps%=
3A%2F%2Fpatchwork.kernel.org%2Fcover%2F11250413%2F&amp;data=3D02%7C01%7Cleo=
nard.crestez%40nxp.com%7C4531c54354d54442d71808d774c02866%7C686ea1d3bc2b4c6=
fa92cd99c5c301635%7C0%7C0%7C637106240968746397&amp;sdata=3Dvyz%2FN2x7OZPCSx=
4Md8yQkOSjPtfNUvW6%2FHtG0bTG1xU%3D&amp;reserved=3D0=0A=
>>=0A=
>> Changes since v1:=0A=
>> * Don't rename or EXPORT_SYMBOL_GPL the freq_qos_apply function; just=0A=
>> drop the static marker.=0A=
>> Link to v1: https://eur01.safelinks.protection.outlook.com/?url=3Dhttps%=
3A%2F%2Fpatchwork.kernel.org%2Fcover%2F11212887%2F&amp;data=3D02%7C01%7Cleo=
nard.crestez%40nxp.com%7C4531c54354d54442d71808d774c02866%7C686ea1d3bc2b4c6=
fa92cd99c5c301635%7C0%7C0%7C637106240968746397&amp;sdata=3DSjcSQmMRZu0z3ATW=
ygBpD8mRToCZT%2FBgQ7U3IRpMUB0%3D&amp;reserved=3D0=0A=
>>=0A=
>> Leonard Crestez (4):=0A=
>>    PM / QoS: Initial kunit test=0A=
>>    PM / QoS: Redefine FREQ_QOS_MAX_DEFAULT_VALUE to S32_MAX=0A=
>>    PM / QoS: Reorder pm_qos/freq_qos/dev_pm_qos structs=0A=
>>    PM / QoS: Restore DEV_PM_QOS_MIN/MAX_FREQUENCY=0A=
>>=0A=
>>   drivers/base/Kconfig          |   4 ++=0A=
>>   drivers/base/power/Makefile   |   1 +=0A=
>>   drivers/base/power/qos-test.c | 117 ++++++++++++++++++++++++++++++++++=
=0A=
>>   drivers/base/power/qos.c      |  73 +++++++++++++++++++--=0A=
>>   include/linux/pm_qos.h        |  86 ++++++++++++++-----------=0A=
>>   kernel/power/qos.c            |   4 +-=0A=
>>   6 files changed, 242 insertions(+), 43 deletions(-)=0A=
>>   create mode 100644 drivers/base/power/qos-test.c=0A=
>>=0A=
>>=0A=
> =0A=
> I have applied the whole series as 5.5 material, but I have reordered the=
 fix=0A=
> (patch [2/4]) before the rest of it and marked it for -stable.=0A=
=0A=
Thanks!=0A=
=0A=
Devfreq maintainers, do you think the devfreq parts could be queued for =0A=
5.5 as well? I'm not sure about the mechanics involved in this since =0A=
devfreq qos depends at build time on this dev_pm_qos series.=0A=
=0A=
Latest version is here: https://patchwork.kernel.org/cover/11252415/=0A=
=0A=
It's RFC because it didn't compile against unpatched linux-next but it's =
=0A=
otherwise a reduced version of a series that went through review and =0A=
testing.=0A=
=0A=
--=0A=
Regards,=0A=
Leonard=0A=
