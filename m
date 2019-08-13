Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id ED2028B49A
	for <lists+linux-kselftest@lfdr.de>; Tue, 13 Aug 2019 11:51:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727298AbfHMJvq (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 13 Aug 2019 05:51:46 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:57898 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727890AbfHMJvp (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 13 Aug 2019 05:51:45 -0400
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x7D9nFOG016489;
        Tue, 13 Aug 2019 09:51:18 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : subject
 : from : to : cc : date : in-reply-to : references : content-type :
 mime-version : content-transfer-encoding; s=corp-2019-08-05;
 bh=kyPIjO27oB72GLTsVcnxsAv0kJDQtfl0IzTAum6ojek=;
 b=kcmhkiuOmv0oYQi5OPzF9osdz7+bo7yoSXgjRgG1NAhUu3WcDaebg2xHw97VJLaCHBcx
 F2jDxB9tMl32E2zoQm5QQHuvfy7mvmNx2nYorz5jehmaU7JqyQVNmL9FH8p+x97cAEGD
 8+etznfdhqt9O+Fky33OsU4QGWoDAHTIJ+uknRlen5oZb8N89l6qtVgLCS+lvqCnoDDf
 iEcok/maVV3tAM21DjTaGWFOn8p+1l5z2bX7VFIDJvMMJLgzlspM5o5N7cO8CAbetZcf
 bn3RW4rcKulilvuQPkJPQ3RPlqF3jQ8iluSepqFZl+711xTqx+vz+yY1FGglA1HIeJF+ pQ== 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : subject
 : from : to : cc : date : in-reply-to : references : content-type :
 mime-version : content-transfer-encoding; s=corp-2018-07-02;
 bh=kyPIjO27oB72GLTsVcnxsAv0kJDQtfl0IzTAum6ojek=;
 b=Nc8KdvEMmM3jNiuK3jeEAFgXthR4fLpum+U9m6yQ/Ysv81woltVn9LNejPlLREsYfMrX
 2LxN/DiBxXCRP7S9QAy0mMeKfEmAnNNQgE69x5Zao2KpoAuINCSpFPW9yNVFPvEK9MPf
 HL5WJ9iBJuqh98WLFJ7FUuGmYzMRYpIA35aE1NjeQ4TLIqSCpfBcU40CEcs1iXqkYPQh
 M7KCxdmC84/wgU0ZNqPi4UxsKzfDp/2+WZLRBGQCekTkCTBBL2nZXCa4E9C3tTPZbmRb
 Je4Ozgen/wJq6jfx/9YbxIL9c6DaCAn4/CjKY/4+nK9QN4dJb1jlmWcZL4KQredQVimI lQ== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by userp2130.oracle.com with ESMTP id 2u9nbtd996-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 13 Aug 2019 09:51:18 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x7D9laLB094626;
        Tue, 13 Aug 2019 09:51:17 GMT
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
        by aserp3030.oracle.com with ESMTP id 2u9m0b5ykf-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 13 Aug 2019 09:51:17 +0000
Received: from abhmp0015.oracle.com (abhmp0015.oracle.com [141.146.116.21])
        by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id x7D9pAXh004636;
        Tue, 13 Aug 2019 09:51:10 GMT
Received: from abi.no.oracle.com (/141.143.213.43)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Tue, 13 Aug 2019 02:51:10 -0700
Message-ID: <f0e1a6efa8f21ab93935c4c19e13b904d4a71f98.camel@oracle.com>
Subject: Re: [RFC 00/19] Integration of Kernel Test Framework (KTF) into the
 kernel tree
From:   Knut Omang <knut.omang@oracle.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-kbuild@vger.kernel.org,
        Shuah Khan <shuah@kernel.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Michal Marek <michal.lkml@markovi.net>,
        Shreyans Devendra Doshi <0xinfosect0r@gmail.com>,
        Alan Maguire <alan.maguire@oracle.com>,
        Brendan Higgins <brendanhiggins@google.com>,
        Kevin Hilman <khilman@baylibre.com>,
        Hidenori Yamaji <hidenori.yamaji@sony.com>,
        Frank Rowand <frowand.list@gmail.com>,
        Timothy Bird <Tim.Bird@sony.com>,
        Luis Chamberlain <mcgrof@kernel.org>,
        "Theodore Ts'o" <tytso@mit.edu>, Daniel Vetter <daniel@ffwll.ch>,
        Stephen Boyd <sboyd@kernel.org>
Date:   Tue, 13 Aug 2019 11:51:05 +0200
In-Reply-To: <20190813082336.GB17627@kroah.com>
References: <cover.92d76bb4f6dcedc971d0b72a49e8e459a98bca54.1565676440.git-series.knut.omang@oracle.com>
         <20190813082336.GB17627@kroah.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.30.5 (3.30.5-1.fc29) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9347 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1906280000 definitions=main-1908130105
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9347 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1906280000
 definitions=main-1908130105
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Tue, 2019-08-13 at 10:23 +0200, Greg Kroah-Hartman wrote:
> On Tue, Aug 13, 2019 at 08:09:15AM +0200, Knut Omang wrote:
> > and in the making::
> > 
> > kunit/			  (kernel only (UML))
> 
> You are going to have to integrate this with kunit, to come up with a
> superset of both in the end.

Yes, I agree - getting to a unified approach has been my intention since I first brought this
up at LPC'17.

> And I do not think that kunit is only UML, it's just that seems to be
> what Brendan tests with, but should work with other arches as well.

If I get Brendan right, it is UML only now but can be extended to also support 
kernels running on real hardware. Still it is kernel only, while KTF also has the 
hybrid mode, where a test can have code and assertions both in user mode and kernel mode.
This is made easier and more streamlined by letting all reporting happen from user mode.

Thanks!
Knut

> thanks,
> 
> greg k-h

