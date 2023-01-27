Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9624467EDA1
	for <lists+linux-kselftest@lfdr.de>; Fri, 27 Jan 2023 19:37:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234935AbjA0Shi (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 27 Jan 2023 13:37:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43668 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234906AbjA0Shg (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 27 Jan 2023 13:37:36 -0500
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F05285CD2A;
        Fri, 27 Jan 2023 10:37:34 -0800 (PST)
Received: from pps.filterd (m0098420.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 30RIQbw5032084;
        Fri, 27 Jan 2023 18:37:31 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : subject :
 from : to : cc : date : in-reply-to : references : content-type :
 content-transfer-encoding : mime-version; s=pp1;
 bh=urV66HWbZhpDrN15YV3AnyXAk9Itc+BmHifeRfarMtM=;
 b=N9szarZq3qQUsp2Yfwk8IWXphI+Z3OnEDaMzySbCdyGNKIyoYKpWXkgH5urwLHrQKHOa
 fe0h60or8k0eKzqBvuZ1c+1JCMHGdYttSLCisXBq4if23okJeCJwnYZjdubuqyq/PX+s
 H+4/8SN89mjMV1l81go4id5oxMhYpDgUbRxcef5Hl0VzrfftFJ4NkH/chbwG6YnCf916
 8WyTXJzXO8gmaY2sLfTQoRGSmcCKmrCn1oaRFyiXFLEVjio13pgHCCyHsMLnbjDCIkk0
 MEI4l30jqn4UQXEAztKslBpimAsocrpONpKFGAGCuJRLRYEbBMQipk3BhwMWjqCYoZ2j CA== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (PPS) with ESMTPS id 3nckw6g7b7-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 27 Jan 2023 18:37:31 +0000
Received: from m0098420.ppops.net (m0098420.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 30RIRYwB004637;
        Fri, 27 Jan 2023 18:37:30 GMT
Received: from ppma03fra.de.ibm.com (6b.4a.5195.ip4.static.sl-reverse.com [149.81.74.107])
        by mx0b-001b2d01.pphosted.com (PPS) with ESMTPS id 3nckw6g7ap-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 27 Jan 2023 18:37:30 +0000
Received: from pps.filterd (ppma03fra.de.ibm.com [127.0.0.1])
        by ppma03fra.de.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 30R6xQPB013377;
        Fri, 27 Jan 2023 18:37:29 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
        by ppma03fra.de.ibm.com (PPS) with ESMTPS id 3n87p6dnkq-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 27 Jan 2023 18:37:28 +0000
Received: from smtpav01.fra02v.mail.ibm.com (smtpav01.fra02v.mail.ibm.com [10.20.54.100])
        by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 30RIbNFN44302658
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 27 Jan 2023 18:37:25 GMT
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id B36BD20040;
        Fri, 27 Jan 2023 18:37:23 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 786582004D;
        Fri, 27 Jan 2023 18:37:23 +0000 (GMT)
Received: from li-7e0de7cc-2d9d-11b2-a85c-de26c016e5ad.ibm.com (unknown [9.171.154.20])
        by smtpav01.fra02v.mail.ibm.com (Postfix) with ESMTP;
        Fri, 27 Jan 2023 18:37:23 +0000 (GMT)
Message-ID: <930bd974894365e88fc68699b59f94114bf7e5ba.camel@linux.ibm.com>
Subject: Re: [RFC PATCH v1] KVM: selftests: Compile s390 tests with
 -march=z10
From:   Nina Schoetterl-Glausch <nsg@linux.ibm.com>
To:     Thomas Huth <thuth@redhat.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Shuah Khan <shuah@kernel.org>,
        Janosch Frank <frankja@linux.ibm.com>,
        Claudio Imbrenda <imbrenda@linux.ibm.com>
Cc:     kvm@vger.kernel.org, linux-kselftest@vger.kernel.org,
        linux-kernel@vger.kernel.org
Date:   Fri, 27 Jan 2023 19:37:23 +0100
In-Reply-To: <df451f90-0809-cd99-4494-c930cf4936e5@redhat.com>
References: <20230127174552.3370169-1-nsg@linux.ibm.com>
         <df451f90-0809-cd99-4494-c930cf4936e5@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.46.3 (3.46.3-1.fc37) 
MIME-Version: 1.0
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: SbYPTV7MtKq1EhBM_Tf3XOKL4twxBz0Z
X-Proofpoint-ORIG-GUID: QVDootv03q7e5hizVSIq3-VT27t-gIvt
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.930,Hydra:6.0.562,FMLib:17.11.122.1
 definitions=2023-01-27_11,2023-01-27_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0
 lowpriorityscore=0 spamscore=0 malwarescore=0 mlxlogscore=999
 clxscore=1015 mlxscore=0 impostorscore=0 adultscore=0 priorityscore=1501
 bulkscore=0 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2301270167
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Fri, 2023-01-27 at 19:12 +0100, Thomas Huth wrote:
> On 27/01/2023 18.45, Nina Schoetterl-Glausch wrote:
> > The guest used in s390 kvm selftests is not be set up to handle all
> > instructions the compiler might emit, i.e. vector instructions, leading
> > to crashes.
> > Limit what the compiler emits to the oldest machine model currently
> > supported by Linux.
> >=20
> > Signed-off-by: Nina Schoetterl-Glausch <nsg@linux.ibm.com>
> > ---
> >=20
> > Should we also set -mtune?
>=20
> I don't think it's really necessary
>=20
> > Since it are vector instructions that caused the problem here, there
> > are some alternatives:
> >   * use -mno-vx
> >   * set the required guest control bit to enable vector instructions on
> >     models supporting them
> >=20
> > -march=3Dz10 might prevent similar issues with other instructions, but =
I
> > don't know if there actually exist other relevant instructions, so it
> > could be needlessly restricting.
>=20
> FWIW, the vector instructions have been introduced with the z13 ... so=
=20
> limiting to the zEC12 could be enough.

Yes, however, if we only want to fix the issue with regards to vector instr=
uctions,
one of the alternatives would be a better solution, IMO.
With regards to the second, I'm not sure what happens on old models if we
unconditionally enable the control bit, I'm guessing it'd be fine.
The question is how likely similar issues are and if we're fine with possib=
ly running into them.
For what it's worth, finding the cause here was easy, tracing kvm-s390 even=
ts showed the faulting
instruction.

>=20
> > diff --git a/tools/testing/selftests/kvm/Makefile b/tools/testing/selft=
ests/kvm/Makefile
> > index 1750f91dd936..df0989949eb5 100644
> > --- a/tools/testing/selftests/kvm/Makefile
> > +++ b/tools/testing/selftests/kvm/Makefile
> > @@ -200,6 +200,9 @@ CFLAGS +=3D -Wall -Wstrict-prototypes -Wuninitializ=
ed -O2 -g -std=3Dgnu99 \
> >   	-I$(LINUX_TOOL_ARCH_INCLUDE) -I$(LINUX_HDR_PATH) -Iinclude \
> >   	-I$(<D) -Iinclude/$(ARCH_DIR) -I ../rseq -I.. $(EXTRA_CFLAGS) \
> >   	$(KHDR_INCLUDES)
> > +ifeq ($(ARCH),s390)
> > +	CFLAGS +=3D -march=3Dz10
> > +endif
>=20
> Starting with z10 sounds sane to me, we still can adjust later if necessa=
ry.
>=20
> Reviewed-by: Thomas Huth <thuth@redhat.com>
>=20
Thanks!

