Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 00DBB632B4B
	for <lists+linux-kselftest@lfdr.de>; Mon, 21 Nov 2022 18:44:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229969AbiKURo4 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 21 Nov 2022 12:44:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36188 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229947AbiKURoy (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 21 Nov 2022 12:44:54 -0500
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3B69D57B69;
        Mon, 21 Nov 2022 09:44:53 -0800 (PST)
Received: from pps.filterd (m0098419.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 2ALGRk5O009093;
        Mon, 21 Nov 2022 17:44:49 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : subject :
 from : to : cc : date : in-reply-to : references : content-type :
 mime-version : content-transfer-encoding; s=pp1;
 bh=ukJQU3ge+0DPRLprFDZHYtYJstKqpOQqUzG3RJjtDKY=;
 b=ixEiCQiYXm1KcrgavtnovwwXO9e5t1vx+QhfnYaM8GfzTdhTsxuDgMhIxdwaPOu5ozan
 n4wSZ+9QOC76qrUVsB5dlnU/uLuzTPu/55XCtsKdrExq4SDqclCHDYTFVxGdFjCjRaL0
 BfCJlkH524K1DqbqMZuKUbUrzViRb7AbS2WB5LgMW0t9s/S+tJ1NhAEn9Bp4o67SAFLO
 fSzkTQUJAT8lqm3UurPnU9snLHu7g8txCJrNXabjEGsAF/vs7wlmFmu+rI+76Smkscq3
 1xcwM3sH+aMRFazXGNRRgFwv5D4WJiyq7BKAMCf5pvRvjqbeVjJpC5KPpmRUbmyRTpWk Gg== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (PPS) with ESMTPS id 3m0cvg1s22-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 21 Nov 2022 17:44:49 +0000
Received: from m0098419.ppops.net (m0098419.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 2ALGf38E024879;
        Mon, 21 Nov 2022 17:44:48 GMT
Received: from ppma05fra.de.ibm.com (6c.4a.5195.ip4.static.sl-reverse.com [149.81.74.108])
        by mx0b-001b2d01.pphosted.com (PPS) with ESMTPS id 3m0cvg1s1j-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 21 Nov 2022 17:44:48 +0000
Received: from pps.filterd (ppma05fra.de.ibm.com [127.0.0.1])
        by ppma05fra.de.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 2ALHbVKr030934;
        Mon, 21 Nov 2022 17:44:46 GMT
Received: from b06avi18878370.portsmouth.uk.ibm.com (b06avi18878370.portsmouth.uk.ibm.com [9.149.26.194])
        by ppma05fra.de.ibm.com with ESMTP id 3kxps8j7st-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 21 Nov 2022 17:44:46 +0000
Received: from d06av26.portsmouth.uk.ibm.com (d06av26.portsmouth.uk.ibm.com [9.149.105.62])
        by b06avi18878370.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 2ALHjNI644958096
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 21 Nov 2022 17:45:24 GMT
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 18493AE051;
        Mon, 21 Nov 2022 17:44:43 +0000 (GMT)
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 5871BAE045;
        Mon, 21 Nov 2022 17:44:42 +0000 (GMT)
Received: from li-7e0de7cc-2d9d-11b2-a85c-de26c016e5ad.ibm.com (unknown [9.171.52.183])
        by d06av26.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Mon, 21 Nov 2022 17:44:42 +0000 (GMT)
Message-ID: <e56e2c58477626dbdc6d4ddcd806459e7ce93b28.camel@linux.ibm.com>
Subject: Re: [PATCH v3 2/9] Documentation: KVM: s390: Describe
 KVM_S390_MEMOP_F_CMPXCHG
From:   Janis Schoetterl-Glausch <scgl@linux.ibm.com>
To:     Bagas Sanjaya <bagasdotme@gmail.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Janosch Frank <frankja@linux.ibm.com>,
        Claudio Imbrenda <imbrenda@linux.ibm.com>,
        Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>
Cc:     David Hildenbrand <david@redhat.com>,
        Jonathan Corbet <corbet@lwn.net>, kvm@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org, linux-s390@vger.kernel.org,
        Paolo Bonzini <pbonzini@redhat.com>,
        Shuah Khan <shuah@kernel.org>,
        Sven Schnelle <svens@linux.ibm.com>
Date:   Mon, 21 Nov 2022 18:44:42 +0100
In-Reply-To: <73ecf737-c523-b4ab-f11f-431bb5fb2c37@gmail.com>
References: <20221117221758.66326-1-scgl@linux.ibm.com>
         <20221117221758.66326-3-scgl@linux.ibm.com>
         <73ecf737-c523-b4ab-f11f-431bb5fb2c37@gmail.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.42.4 (3.42.4-2.fc35) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: xcZfCWc2vgaEHtwQ26s-Mj0whSdSWr9i
X-Proofpoint-ORIG-GUID: olU0MKShioiM4yJlr6NsYzJVdYNWNhc0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-11-21_14,2022-11-18_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 bulkscore=0 phishscore=0 malwarescore=0 impostorscore=0 mlxscore=0
 clxscore=1015 priorityscore=1501 suspectscore=0 spamscore=0
 mlxlogscore=765 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2210170000 definitions=main-2211210132
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Fri, 2022-11-18 at 08:50 +0700, Bagas Sanjaya wrote:
> On 11/18/22 05:17, Janis Schoetterl-Glausch wrote:
> > +For write accesses, the KVM_S390_MEMOP_F_CMPXCHG might be supported.
> > +In this case, instead of doing an unconditional write, the access occurs only
> > +if the target location contains the "size" byte long value pointed to by
> > +"old_p". This is performed as an atomic cmpxchg. "size" must be a power of two
> > +up to and including 16.
> > +The value at the target location is written to the location "old_p" points to.
> > +If the exchange did not take place because the target value doesn't match the
> > +old value KVM_S390_MEMOP_R_NO_XCHG is returned.
> > +The KVM_S390_MEMOP_F_CMPXCHG flag is supported if KVM_CAP_S390_MEM_OP_EXTENSION
> > +has bit 1 (i.e. bit with value 2) set.
> >  
> 
> Is KVM_S390_MEMOP_F_CMPXCHG supported with conditions (as you implied)?
> 
I'm afraid I don't quite understand the question.
It is supported if the capability says it is, i.e. if bit 1 is set.
