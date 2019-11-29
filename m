Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C167A10D128
	for <lists+linux-kselftest@lfdr.de>; Fri, 29 Nov 2019 06:55:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726205AbfK2Fz1 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 29 Nov 2019 00:55:27 -0500
Received: from mail-eopbgr20046.outbound.protection.outlook.com ([40.107.2.46]:14048
        "EHLO EUR02-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726164AbfK2Fz1 (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 29 Nov 2019 00:55:27 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=E585vo0DJCcnPf8vYOWGmIr5QvSkhB8tzN+MmR0udo6tHSmgcFGMIpqbNnG0stDWyDxTIRDLDEZ3BJmwd4cQ8hUmnIO+1feGVSTK2Z0E/Eu/99Rx8v2tNuEUVHr1Xft0Iyf+RwzCTLFD+Rqv3yaBvvf9wWvI2KzMI60lfPkWz+t10TJTdp/ZBEtoMFgP59ASW25hto9dt1KO8h6oWZFzOUC+2mhYlmPoxcu4J7d1VFsKA/afO8eurldEkxxqABxb/7h7pGTDFV/uPG3GqzUZb4fjYR+mYxF/j62JIEHzPD1J0QGpbj3O4NoztmfP5bSsQ7U8N1UcYvIDw1nsYB/SfQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lgWxRLzDsK+dsR4VmlOsG9hUoUebdKHV+B5V61RCfxM=;
 b=fRQIsOMG674p6g+T1EVSjSkMBPZtGjlXP0cacogd+G7oqIc/Yl2wdIWK0NpnQLJPyq68uFlf8F7c4Hky8idcuUV/+1leUgx7vJUUG5G0R/WtktVR/thbiBeRHdNrWXa+GNympknjSEq3FA0/0UqpZbZJvQ0wpS/avz72ambncGdhzoRrEbm+aPoCmYNpHbuJC93L6yBihhgRrgG8gUwQTspQ0zpi8OtwgjeaKYwnZjepqrBNkcv3+w/hPVErM9Ep01gVo9g9mXMg0/JAb6KwZ18geIxIverRrRlq6+Hkhm7HuJw+6teDmVJ8ihE8XZMJF4Y7Cvh68Xl121qw9/gMAg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lgWxRLzDsK+dsR4VmlOsG9hUoUebdKHV+B5V61RCfxM=;
 b=CXfBy1LtPpf4m6ssQZ7yz3CTidk9ka9MlE89tlIBA85PQO5yn3B+yv8HlklyxLvVzTub2wuOCzGvyaEsZzWVpE/7IeZS5pfkh4qkmMkIDoA0mgUsf41wreTUyWEJI9HyduW62alwwgb4O1e3mb7hTA3Wt1UM5xlu5jYQO4LScHQ=
Received: from VI1PR04MB7023.eurprd04.prod.outlook.com (10.186.159.144) by
 VI1PR04MB6832.eurprd04.prod.outlook.com (52.133.247.13) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2495.18; Fri, 29 Nov 2019 05:55:21 +0000
Received: from VI1PR04MB7023.eurprd04.prod.outlook.com
 ([fe80::dd0c:72dc:e462:16b3]) by VI1PR04MB7023.eurprd04.prod.outlook.com
 ([fe80::dd0c:72dc:e462:16b3%5]) with mapi id 15.20.2495.014; Fri, 29 Nov 2019
 05:55:21 +0000
From:   Leonard Crestez <leonard.crestez@nxp.com>
To:     Matthias Kaehlcke <mka@chromium.org>
CC:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        MyungJoo Ham <myungjoo.ham@samsung.com>,
        Kyungmin Park <kyungmin.park@samsung.com>,
        =?iso-8859-2?Q?Artur_=A6wigo=F1?= <a.swigon@partner.samsung.com>,
        Angus Ainslie <angus@akkea.ca>,
        Brendan Higgins <brendanhiggins@google.com>,
        "linux-kselftest@vger.kernel.org" <linux-kselftest@vger.kernel.org>,
        "kunit-dev@googlegroups.com" <kunit-dev@googlegroups.com>,
        "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
        dl-linux-imx <linux-imx@nxp.com>
Subject: Re: [PATCH v4 4/4] PM / QoS: Restore DEV_PM_QOS_MIN/MAX_FREQUENCY
Thread-Topic: [PATCH v4 4/4] PM / QoS: Restore DEV_PM_QOS_MIN/MAX_FREQUENCY
Thread-Index: AQHVpGybpkySS4UVM0OKioMCL+zcEA==
Date:   Fri, 29 Nov 2019 05:55:21 +0000
Message-ID: <VI1PR04MB702332344392014F704A2D12EE460@VI1PR04MB7023.eurprd04.prod.outlook.com>
References: <cover.1574781196.git.leonard.crestez@nxp.com>
 <44cfaddb5be6403f687a0e56e57f17925b9a521b.1574781196.git.leonard.crestez@nxp.com>
 <20191126210130.GE228856@google.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=leonard.crestez@nxp.com; 
x-originating-ip: [92.121.36.197]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: ad3f3663-bd49-499c-a270-08d77490b86d
x-ms-traffictypediagnostic: VI1PR04MB6832:|VI1PR04MB6832:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <VI1PR04MB68324ED8755AA09A1CF5DA4BEE460@VI1PR04MB6832.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8273;
x-forefront-prvs: 0236114672
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(39860400002)(396003)(376002)(136003)(346002)(366004)(189003)(199004)(30864003)(76116006)(7696005)(256004)(81166006)(7416002)(6916009)(478600001)(33656002)(14454004)(8936002)(81156014)(52536014)(66556008)(66446008)(66066001)(76176011)(3846002)(66476007)(305945005)(5660300002)(91956017)(74316002)(6116002)(64756008)(7736002)(186003)(86362001)(54906003)(8676002)(102836004)(229853002)(66946007)(6436002)(55016002)(316002)(53546011)(9686003)(25786009)(4326008)(71200400001)(71190400001)(14444005)(6246003)(44832011)(99286004)(26005)(446003)(6506007)(2906002);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR04MB6832;H:VI1PR04MB7023.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 3jT1I8JWTkfbD7Z0HdNiq87CJ3tMV81ZJCeK4M9ruWY6IE5+WmKP6BE4WXuaKIbtVeECs9D5OP6/4crQGm0B70AMg/N6Ougj9hNET4T2SazjWNUTOHiCYdqAfCDZkeMolLnC3uc+qmwM2EZeS5RehVMNOghFwUWIx0wGaGd8VlSG7vviIxrbXlpgsHZE5dsyImCfxEMVAsEpXn7EXqbYvMWLz9SOj7bYCMDL+24JUpw+6tZWylvSD7/wc8Ek3qNQbxelC3AGJz+x/SRL+1B6bcs4cWFwFXBNdvxPvbmlzyFchQ7UxhaqZEaSxbozY+NGK+3mP3fyimnTizoLg4/LlKnkf9C6QmDmha7eNxuN5rd/1IBQh8IsUVgcvlbLZOMED/J7L8ZpR3nQTkthOtWUtLqstAWxU7II62MWCD+KoEG+B8VMiHOKFs2DZNggGoZL
Content-Type: text/plain; charset="iso-8859-2"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ad3f3663-bd49-499c-a270-08d77490b86d
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Nov 2019 05:55:21.3623
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 813NNhqpm6JejdjDHARnui9aLHgyL2dCLMpy4NszWNp9tBaisZK1kOn/3hPgeZyF2jre/3GXRTFkLxzgOECk8Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB6832
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On 26.11.2019 23:01, Matthias Kaehlcke wrote:=0A=
> On Tue, Nov 26, 2019 at 05:17:13PM +0200, Leonard Crestez wrote:=0A=
>> Support for adding per-device frequency limits was removed in=0A=
>> commit 2aac8bdf7a0f ("PM: QoS: Drop frequency QoS types from device PM Q=
oS")=0A=
>> after cpufreq switched to use a new "freq_constraints" construct.=0A=
>>=0A=
>> Restore support for per-device freq limits but base this upon=0A=
>> freq_constraints. This is primarily meant to be used by the devfreq=0A=
>> subsystem.=0A=
>>=0A=
>> This removes the "static" marking on freq_qos_apply but does not export=
=0A=
>> it for modules.=0A=
>>=0A=
>> Signed-off-by: Leonard Crestez <leonard.crestez@nxp.com>=0A=
>> ---=0A=
>>   drivers/base/power/qos.c | 73 ++++++++++++++++++++++++++++++++++++----=
=0A=
>>   include/linux/pm_qos.h   | 12 +++++++=0A=
>>   kernel/power/qos.c       |  4 ++-=0A=
>>   3 files changed, 82 insertions(+), 7 deletions(-)=0A=
>>=0A=
>> diff --git a/drivers/base/power/qos.c b/drivers/base/power/qos.c=0A=
>> index 350dcafd751f..8e93167f1783 100644=0A=
>> --- a/drivers/base/power/qos.c=0A=
>> +++ b/drivers/base/power/qos.c=0A=
>> @@ -113,14 +113,24 @@ s32 dev_pm_qos_read_value(struct device *dev, enum=
 dev_pm_qos_req_type type)=0A=
>>   	unsigned long flags;=0A=
>>   	s32 ret;=0A=
>>   =0A=
>>   	spin_lock_irqsave(&dev->power.lock, flags);=0A=
>>   =0A=
>> -	if (type =3D=3D DEV_PM_QOS_RESUME_LATENCY) {=0A=
>> +	switch (type) {=0A=
>> +	case DEV_PM_QOS_RESUME_LATENCY:=0A=
>>   		ret =3D IS_ERR_OR_NULL(qos) ? PM_QOS_RESUME_LATENCY_NO_CONSTRAINT=0A=
>>   			: pm_qos_read_value(&qos->resume_latency);=0A=
>> -	} else {=0A=
>> +		break;=0A=
>> +	case DEV_PM_QOS_MIN_FREQUENCY:=0A=
>> +		ret =3D IS_ERR_OR_NULL(qos) ? PM_QOS_MIN_FREQUENCY_DEFAULT_VALUE=0A=
>> +			: freq_qos_read_value(&qos->freq, FREQ_QOS_MIN);=0A=
>> +		break;=0A=
>> +	case DEV_PM_QOS_MAX_FREQUENCY:=0A=
>> +		ret =3D IS_ERR_OR_NULL(qos) ? PM_QOS_MAX_FREQUENCY_DEFAULT_VALUE=0A=
>> +			: freq_qos_read_value(&qos->freq, FREQ_QOS_MAX);=0A=
>> +		break;=0A=
>> +	default:=0A=
>>   		WARN_ON(1);=0A=
>>   		ret =3D 0;=0A=
>>   	}=0A=
>>   =0A=
>>   	spin_unlock_irqrestore(&dev->power.lock, flags);=0A=
>> @@ -157,10 +167,14 @@ static int apply_constraint(struct dev_pm_qos_requ=
est *req,=0A=
>>   		if (ret) {=0A=
>>   			value =3D pm_qos_read_value(&qos->latency_tolerance);=0A=
>>   			req->dev->power.set_latency_tolerance(req->dev, value);=0A=
>>   		}=0A=
>>   		break;=0A=
>> +	case DEV_PM_QOS_MIN_FREQUENCY:=0A=
>> +	case DEV_PM_QOS_MAX_FREQUENCY:=0A=
>> +		ret =3D freq_qos_apply(&req->data.freq, action, value);=0A=
>> +		break;=0A=
>>   	case DEV_PM_QOS_FLAGS:=0A=
>>   		ret =3D pm_qos_update_flags(&qos->flags, &req->data.flr,=0A=
>>   					  action, value);=0A=
>>   		break;=0A=
>>   	default:=0A=
>> @@ -207,10 +221,12 @@ static int dev_pm_qos_constraints_allocate(struct =
device *dev)=0A=
>>   	c->target_value =3D PM_QOS_LATENCY_TOLERANCE_DEFAULT_VALUE;=0A=
>>   	c->default_value =3D PM_QOS_LATENCY_TOLERANCE_DEFAULT_VALUE;=0A=
>>   	c->no_constraint_value =3D PM_QOS_LATENCY_TOLERANCE_NO_CONSTRAINT;=0A=
>>   	c->type =3D PM_QOS_MIN;=0A=
>>   =0A=
>> +	freq_constraints_init(&qos->freq);=0A=
>> +=0A=
>>   	INIT_LIST_HEAD(&qos->flags.list);=0A=
>>   =0A=
>>   	spin_lock_irq(&dev->power.lock);=0A=
>>   	dev->power.qos =3D qos;=0A=
>>   	spin_unlock_irq(&dev->power.lock);=0A=
>> @@ -267,10 +283,24 @@ void dev_pm_qos_constraints_destroy(struct device =
*dev)=0A=
>>   	plist_for_each_entry_safe(req, tmp, &c->list, data.pnode) {=0A=
>>   		apply_constraint(req, PM_QOS_REMOVE_REQ, PM_QOS_DEFAULT_VALUE);=0A=
>>   		memset(req, 0, sizeof(*req));=0A=
>>   	}=0A=
>>   =0A=
>> +	c =3D &qos->freq.min_freq;=0A=
>> +	plist_for_each_entry_safe(req, tmp, &c->list, data.freq.pnode) {=0A=
>> +		apply_constraint(req, PM_QOS_REMOVE_REQ,=0A=
>> +				 PM_QOS_MIN_FREQUENCY_DEFAULT_VALUE);=0A=
>> +		memset(req, 0, sizeof(*req));=0A=
>> +	}=0A=
>> +=0A=
>> +	c =3D &qos->freq.max_freq;=0A=
>> +	plist_for_each_entry_safe(req, tmp, &c->list, data.freq.pnode) {=0A=
>> +		apply_constraint(req, PM_QOS_REMOVE_REQ,=0A=
>> +				 PM_QOS_MAX_FREQUENCY_DEFAULT_VALUE);=0A=
>> +		memset(req, 0, sizeof(*req));=0A=
>> +	}=0A=
>> +=0A=
> =0A=
> nit: these loops look a bit redundant, might be worth to encapsulate them=
 in a=0A=
> macro.=0A=
=0A=
There are only 2 identical loops though? Other requests to be cleared =0A=
are enumerated in slightly different ways.=0A=
=0A=
A pm_qos_for_each_request macro could be added but it would only be used =
=0A=
in a handful of places.=0A=
=0A=
>>   	f =3D &qos->flags;=0A=
>>   	list_for_each_entry_safe(req, tmp, &f->list, data.flr.node) {=0A=
>>   		apply_constraint(req, PM_QOS_REMOVE_REQ, PM_QOS_DEFAULT_VALUE);=0A=
>>   		memset(req, 0, sizeof(*req));=0A=
>>   	}=0A=
>> @@ -312,15 +342,26 @@ static int __dev_pm_qos_add_request(struct device =
*dev,=0A=
>>   		ret =3D -ENODEV;=0A=
>>   	else if (!dev->power.qos)=0A=
>>   		ret =3D dev_pm_qos_constraints_allocate(dev);=0A=
>>   =0A=
>>   	trace_dev_pm_qos_add_request(dev_name(dev), type, value);=0A=
>> -	if (!ret) {=0A=
>> -		req->dev =3D dev;=0A=
>> -		req->type =3D type;=0A=
>> +	if (ret)=0A=
>> +		return ret;=0A=
>> +=0A=
>> +	req->dev =3D dev;=0A=
>> +	req->type =3D type;=0A=
>> +	if (req->type =3D=3D DEV_PM_QOS_MIN_FREQUENCY)=0A=
>> +		ret =3D freq_qos_add_request(&dev->power.qos->freq,=0A=
>> +					   &req->data.freq,=0A=
>> +					   FREQ_QOS_MIN, value);=0A=
>> +	else if (req->type =3D=3D DEV_PM_QOS_MAX_FREQUENCY)=0A=
>> +		ret =3D freq_qos_add_request(&dev->power.qos->freq,=0A=
>> +					   &req->data.freq,=0A=
>> +					   FREQ_QOS_MAX, value);=0A=
>> +	else=0A=
>>   		ret =3D apply_constraint(req, PM_QOS_ADD_REQ, value);=0A=
>> -	}=0A=
>> +=0A=
>>   	return ret;=0A=
>>   }=0A=
>>   =0A=
>>   /**=0A=
>>    * dev_pm_qos_add_request - inserts new qos request into the list=0A=
>> @@ -380,10 +421,14 @@ static int __dev_pm_qos_update_request(struct dev_=
pm_qos_request *req,=0A=
>>   	switch(req->type) {=0A=
>>   	case DEV_PM_QOS_RESUME_LATENCY:=0A=
>>   	case DEV_PM_QOS_LATENCY_TOLERANCE:=0A=
>>   		curr_value =3D req->data.pnode.prio;=0A=
>>   		break;=0A=
>> +	case DEV_PM_QOS_MIN_FREQUENCY:=0A=
>> +	case DEV_PM_QOS_MAX_FREQUENCY:=0A=
>> +		curr_value =3D req->data.freq.pnode.prio;=0A=
>> +		break;=0A=
>>   	case DEV_PM_QOS_FLAGS:=0A=
>>   		curr_value =3D req->data.flr.flags;=0A=
>>   		break;=0A=
>>   	default:=0A=
>>   		return -EINVAL;=0A=
>> @@ -505,10 +550,18 @@ int dev_pm_qos_add_notifier(struct device *dev, st=
ruct notifier_block *notifier,=0A=
>>   	switch (type) {=0A=
>>   	case DEV_PM_QOS_RESUME_LATENCY:=0A=
>>   		ret =3D blocking_notifier_chain_register(dev->power.qos->resume_late=
ncy.notifiers,=0A=
>>   						       notifier);=0A=
>>   		break;=0A=
>> +	case DEV_PM_QOS_MIN_FREQUENCY:=0A=
>> +		ret =3D freq_qos_add_notifier(&dev->power.qos->freq,=0A=
>> +					    FREQ_QOS_MIN, notifier);=0A=
>> +		break;=0A=
>> +	case DEV_PM_QOS_MAX_FREQUENCY:=0A=
>> +		ret =3D freq_qos_add_notifier(&dev->power.qos->freq,=0A=
>> +					    FREQ_QOS_MAX, notifier);=0A=
>> +		break;=0A=
>>   	default:=0A=
>>   		WARN_ON(1);=0A=
>>   		ret =3D -EINVAL;=0A=
>>   	}=0A=
>>   =0A=
>> @@ -544,10 +597,18 @@ int dev_pm_qos_remove_notifier(struct device *dev,=
=0A=
>>   	switch (type) {=0A=
>>   	case DEV_PM_QOS_RESUME_LATENCY:=0A=
>>   		ret =3D blocking_notifier_chain_unregister(dev->power.qos->resume_la=
tency.notifiers,=0A=
>>   							 notifier);=0A=
>>   		break;=0A=
>> +	case DEV_PM_QOS_MIN_FREQUENCY:=0A=
>> +		ret =3D freq_qos_remove_notifier(&dev->power.qos->freq,=0A=
>> +					       FREQ_QOS_MIN, notifier);=0A=
>> +		break;=0A=
>> +	case DEV_PM_QOS_MAX_FREQUENCY:=0A=
>> +		ret =3D freq_qos_remove_notifier(&dev->power.qos->freq,=0A=
>> +					       FREQ_QOS_MAX, notifier);=0A=
>> +		break;=0A=
>>   	default:=0A=
>>   		WARN_ON(1);=0A=
>>   		ret =3D -EINVAL;=0A=
>>   	}=0A=
>>   =0A=
>> diff --git a/include/linux/pm_qos.h b/include/linux/pm_qos.h=0A=
>> index 678fec6da5b9..19eafca5680e 100644=0A=
>> --- a/include/linux/pm_qos.h=0A=
>> +++ b/include/linux/pm_qos.h=0A=
>> @@ -32,10 +32,12 @@ enum pm_qos_flags_status {=0A=
>>   #define PM_QOS_CPU_DMA_LAT_DEFAULT_VALUE	(2000 * USEC_PER_SEC)=0A=
>>   #define PM_QOS_RESUME_LATENCY_DEFAULT_VALUE	PM_QOS_LATENCY_ANY=0A=
>>   #define PM_QOS_RESUME_LATENCY_NO_CONSTRAINT	PM_QOS_LATENCY_ANY=0A=
>>   #define PM_QOS_RESUME_LATENCY_NO_CONSTRAINT_NS	PM_QOS_LATENCY_ANY_NS=
=0A=
>>   #define PM_QOS_LATENCY_TOLERANCE_DEFAULT_VALUE	0=0A=
>> +#define PM_QOS_MIN_FREQUENCY_DEFAULT_VALUE	0=0A=
>> +#define PM_QOS_MAX_FREQUENCY_DEFAULT_VALUE	FREQ_QOS_MAX_DEFAULT_VALUE=
=0A=
>>   #define PM_QOS_LATENCY_TOLERANCE_NO_CONSTRAINT	(-1)=0A=
>>   =0A=
>>   #define PM_QOS_FLAG_NO_POWER_OFF	(1 << 0)=0A=
>>   =0A=
>>   struct pm_qos_request {=0A=
>> @@ -99,25 +101,29 @@ struct freq_qos_request {=0A=
>>   =0A=
>>   =0A=
>>   enum dev_pm_qos_req_type {=0A=
>>   	DEV_PM_QOS_RESUME_LATENCY =3D 1,=0A=
>>   	DEV_PM_QOS_LATENCY_TOLERANCE,=0A=
>> +	DEV_PM_QOS_MIN_FREQUENCY,=0A=
>> +	DEV_PM_QOS_MAX_FREQUENCY,=0A=
>>   	DEV_PM_QOS_FLAGS,=0A=
>>   };=0A=
>>   =0A=
>>   struct dev_pm_qos_request {=0A=
>>   	enum dev_pm_qos_req_type type;=0A=
>>   	union {=0A=
>>   		struct plist_node pnode;=0A=
>>   		struct pm_qos_flags_request flr;=0A=
>> +		struct freq_qos_request freq;=0A=
>>   	} data;=0A=
>>   	struct device *dev;=0A=
>>   };=0A=
>>   =0A=
>>   struct dev_pm_qos {=0A=
>>   	struct pm_qos_constraints resume_latency;=0A=
>>   	struct pm_qos_constraints latency_tolerance;=0A=
>> +	struct freq_constraints freq;=0A=
>>   	struct pm_qos_flags flags;=0A=
>>   	struct dev_pm_qos_request *resume_latency_req;=0A=
>>   	struct dev_pm_qos_request *latency_tolerance_req;=0A=
>>   	struct dev_pm_qos_request *flags_req;=0A=
>>   };=0A=
>> @@ -212,10 +218,14 @@ static inline s32 dev_pm_qos_read_value(struct dev=
ice *dev,=0A=
>>   					enum dev_pm_qos_req_type type)=0A=
>>   {=0A=
>>   	switch (type) {=0A=
>>   	case DEV_PM_QOS_RESUME_LATENCY:=0A=
>>   		return PM_QOS_RESUME_LATENCY_NO_CONSTRAINT;=0A=
>> +	case DEV_PM_QOS_MIN_FREQUENCY:=0A=
>> +		return PM_QOS_MIN_FREQUENCY_DEFAULT_VALUE;=0A=
>> +	case DEV_PM_QOS_MAX_FREQUENCY:=0A=
>> +		return PM_QOS_MAX_FREQUENCY_DEFAULT_VALUE;=0A=
>>   	default:=0A=
>>   		WARN_ON(1);=0A=
>>   		return 0;=0A=
>>   	}=0A=
>>   }=0A=
>> @@ -291,10 +301,12 @@ s32 freq_qos_read_value(struct freq_constraints *q=
os,=0A=
>>   int freq_qos_add_request(struct freq_constraints *qos,=0A=
>>   			 struct freq_qos_request *req,=0A=
>>   			 enum freq_qos_req_type type, s32 value);=0A=
>>   int freq_qos_update_request(struct freq_qos_request *req, s32 new_valu=
e);=0A=
>>   int freq_qos_remove_request(struct freq_qos_request *req);=0A=
>> +int freq_qos_apply(struct freq_qos_request *req,=0A=
>> +		   enum pm_qos_req_action action, s32 value);=0A=
>>   =0A=
>>   int freq_qos_add_notifier(struct freq_constraints *qos,=0A=
>>   			  enum freq_qos_req_type type,=0A=
>>   			  struct notifier_block *notifier);=0A=
>>   int freq_qos_remove_notifier(struct freq_constraints *qos,=0A=
>> diff --git a/kernel/power/qos.c b/kernel/power/qos.c=0A=
>> index a45cba7df0ae..83edf8698118 100644=0A=
>> --- a/kernel/power/qos.c=0A=
>> +++ b/kernel/power/qos.c=0A=
>> @@ -712,12 +712,14 @@ s32 freq_qos_read_value(struct freq_constraints *q=
os,=0A=
>>   /**=0A=
>>    * freq_qos_apply - Add/modify/remove frequency QoS request.=0A=
>>    * @req: Constraint request to apply.=0A=
>>    * @action: Action to perform (add/update/remove).=0A=
>>    * @value: Value to assign to the QoS request.=0A=
>> + *=0A=
>> + * This is only meant to be called from inside pm_qos, not drivers.=0A=
>>    */=0A=
>> -static int freq_qos_apply(struct freq_qos_request *req,=0A=
>> +int freq_qos_apply(struct freq_qos_request *req,=0A=
>>   			  enum pm_qos_req_action action, s32 value)=0A=
>>   {=0A=
>>   	int ret;=0A=
>>   =0A=
>>   	switch(req->type) {=0A=
> =0A=
> Reviewed-by: Matthias Kaehlcke <mka@chromium.org>=0A=
> Tested-by: Matthias Kaehlcke <mka@chromium.org>=0A=
=0A=
Thanks for taking the time to look into this.=0A=
